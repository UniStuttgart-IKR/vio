import sys
import re

HEADERMSG = "# generated from {0} by riscvio-preproc.py by LeyLux Group\n"
ALLOWEDCOOBJNAMES = "[a-zA-Z0-9_]+"
ALLOWEDFNEXPR = "[a-zA-Z0-9]+"


class ParseException(Exception):
    pass


def convertComments(contents) -> []:
    newconts = []

    for cont in contents:
        newconts.append(re.sub("//(.*)\n", "#\\1\n", cont))

    return newconts


def applyMacros(contents) -> []:
    MACROS = [
        ["lcp\\s*([0-7a-zA-Z]*)\\s*,\\s*([0-7a-zA-Z]*)\\(([0-7a-zA-Z]*)\\)", "lp\t\\1, \\2(\\3)\nsp\tzero, \\2(\\3)"],
        ["lcp.r\\s*([0-7a-zA-Z]*)\\s*,\\s*([0-7a-zA-Z]*)\\(([0-7a-zA-Z]*)\\)", "lp.r\t\\1, \\2(\\3)\nsp.r\tzero, \\2(\\3)"],
        ["scp\\s*([0-7a-zA-Z]*)\\s*,\\s*([0-7a-zA-Z]*)\\(([0-7a-zA-Z]*)\\)", "sp\t\\1, \\2(\\3)\naddi\t\\1, zero, 0"],
        ["scp.r\\s*([0-7a-zA-Z]*)\\s*,\\s*([0-7a-zA-Z]*)\\(([0-7a-zA-Z]*)\\)", "sp.r\t\\1, \\2(\\3)\naddi\t\\1, zero, 0"],
        ["pusht\\s*([0-7a-zA-Z]*)\\s*,\\s*([0-7a-zA-Z]*)", "alci\tframe, \\1, \\2"],
    ]
    newcontents = []

    for content in contents:
        for macro in MACROS:
            content = re.sub(macro[0], macro[1], content)

        newcontents.append(content)

    return newcontents


def markChar(i):
    print(" " * i + "^")


def markObjectPositions(obj, contents) -> None:
    print("              " + contents.replace("\n", "N").replace("\t", "T"))
    for name in ["hdrstartpos", "hdrendpos", "hdrfnstartpos", "endpos"]:
        print(name.ljust(len("            : ")), end="")
        markChar(obj[name][1])


def findCOs(contents) -> []:
    pobjects = []
    for i, content in enumerate(contents):
        COmatches = re.finditer("(@" + ALLOWEDCOOBJNAMES + "[>:])([\\S\n\t\v]*)private\n", content)

        for match in COmatches:
            pobjects.append({
                "type": "code",
                "name": match.group(1).replace(">", "").replace(":", "").replace("@", ""),
                "super": ">" in match.group(1),
                "hdrstartpos": [i, match.span(1)[0] + 1],
                "hdrendpos": [i, match.span(2)[1]],
                "hdrfnstartpos": [i, match.span(1)[1]],
                "endpos": [-1, -1],
                "publicfns": [],
                "allfns": []
            })

    return pobjects

def findDOs(contents) -> []:
    pobjects = []

    for i, content in enumerate(contents):
        COmatches = re.finditer("\n(" + ALLOWEDCOOBJNAMES + "): object\n", content)

        for match in COmatches:
            pobjects.append({
                "type": "data",
                "name": match.group(1),
                "hdrstartpos": [i, match.span(1)[0] + 1],
                "hdrendpos": [i, match.span(1)[1]],
                "endpos": [-1, -1]
            })

    return pobjects


def calcCOregions(coobjects, contents) -> [{}]:
    coobjectsnew = coobjects[:]
    for i, coobj in enumerate(coobjectsnew):
        if i != len(coobjects) - 1:
            coobj["endpos"][1] = coobjects[(i + 1)]["hdrstartpos"][1] - 1
        else:
            coobj["endpos"][0] = coobj["hdrstartpos"][0]
            coobj["endpos"][1] = len(contents[coobj["endpos"][0]]) - 1

    return coobjectsnew


def extractPublicFuncs(coobjects, contents) -> [{}]:
    coobjectsnew = coobjects[:]

    for i, coobj in enumerate(coobjectsnew):
        if coobj["type"] == "code":
            hdrfuncregion = contents[coobj["hdrfnstartpos"][0]][coobj["hdrfnstartpos"][1]:coobj["hdrendpos"][1]]

            funcnames = [x for x in hdrfuncregion.split("\n") if x != ""]

            if len(funcnames) == 0:
                raise ParseException({"msg": "Code object without public functions", "location": coobj["hdrfnstartpos"][1],
                                    "fileIdx": coobj["hdrfnstartpos"][0]})
            for i, funcname in enumerate(funcnames):
                coobj["publicfns"].append([funcname, i])

    return coobjectsnew


def extractAllFuncs(pobjects, contents) -> [{}]:
    coobjectsnew = pobjects[:]

    for i, coobj in enumerate(coobjectsnew):
        if coobj["type"] == "code":
            cofnregion = contents[coobj["hdrendpos"][0]][coobj["hdrendpos"][1]:coobj["endpos"][1]]
            #print(">" + cofnregion + "<")
            labelMatches = re.finditer("\n({}):".format(ALLOWEDFNEXPR), cofnregion)

            for match in labelMatches:
                coobj["allfns"].append(match.group(1))

    return coobjectsnew


def checkPubicFNExistance(pobjects) -> None:
    for pobject in pobjects:
        if pobject["type"] == "code":
            for publfn in pobject["publicfns"]:
                if publfn[0] not in [x[0] for x in pobject["allfns"]]:
                    raise ParseException(
                        {"msg": "Public funtion '{}' does not exist!".format(publfn[0]), "location": pobject["hdrfnstartpos"][1],
                        "fileIdx": pobject["hdrfnstartpos"][0]})


def advancepobjectRefs(insertpos, insertlen, pobjects):
    for i, pobject in enumerate(pobjects):
        for fieldname in ["hdrstartpos", "hdrendpos", "hdrfnstartpos", "endpos"]:
            try:
                if pobjects[i][fieldname][1] >= insertpos:
                    pobjects[i][fieldname][1] += insertlen
            except KeyError:
                pass


def insertSectionEndLabels(contents, pobjects) -> []:
    newcontents = contents[:]

    for pobject in pobjects:
        fileId = pobject["endpos"][0]
        label = "\n{0}.end:\n\n\n".format(pobject["name"])
        newcontents[fileId] = newcontents[fileId][:(pobject["endpos"][1])] + label + newcontents[fileId][
                                                                                        (pobject["endpos"][1]):]
        advancepobjectRefs(pobject["endpos"][1], len(label), pobjects)


    return newcontents


def replaceCOHeaders(contents, pobjects) -> [str]:
    newcontents = []

    hdrReplacements = []
    for pobject in pobjects:
        if pobject["type"] == "code":
            dstexpr = ""
            if pobject["name"] != "core":
                dstexpr += ".align 3\n"
                
            if pobject["super"]:
                srcexpr = "(@{}>)([\\S\n\t\v]*)private\n".format(pobject["name"])
                dstexpr += '.section {0}, "xa"\n.word {0}.trampEnd - {0}.trampStart\n.word ({0}.end - {0}.trampStart - 4)\n\n{0}.trampStart:\n'.format(
                    pobject["name"])
            else:
                srcexpr = "(@{}:)([\\S\n\t\v]*)private\n".format(pobject["name"])
                dstexpr += '.section {0}, "xa"\n.word {0}.trampEnd - {0}.trampStart\n.word {0}.end - {0}.trampStart - 4\n\n{0}.trampStart:\n'.format(
                    pobject["name"])

            for fct in pobject["publicfns"]:
                dstexpr += "{0}.{1}_: j {0}.{1}\n".format(pobject["name"], fct[0])

            dstexpr += "{0}.trampEnd:\n\n".format(pobject["name"])

            hdrReplacements.append([srcexpr, dstexpr])

    for content in contents:
        for hdrReplacement in hdrReplacements:
            content = re.sub(hdrReplacement[0], hdrReplacement[1], content)

        newcontents.append(content)

    return newcontents


def replaceDataObjHeaders(contents, pobjects) -> []:
    newcontents = []

    replacements = []
    for pobject in pobjects:
        if pobject["type"] == "data":
            dstexpr = ".align 3\n"
            srcexpr = "\n({}): object\n".format(pobject["name"])
            dstexpr += '.section {0}\n.word 0 # todo: add ptr support\n.word ({0}.end - {0})\n\n{0}:\n'.format(pobject["name"])


            replacements.append([srcexpr, dstexpr])

            advancepobjectRefs(pobject["endpos"][1], len(dstexpr) - len(srcexpr), pobjects)

    for content in contents:
        for replacement in replacements:
            content = re.sub(replacement[0], replacement[1], content)

        newcontents.append(content)

    return newcontents


def expandFunctionNames(contents, pobjects) -> []:
    newcontents = contents[:]

    for i, pobject in enumerate(pobjects):
        if pobject["type"] == "code":
            pobjectStr = newcontents[pobject["hdrendpos"][0]][pobject["hdrendpos"][1]:pobject["endpos"][1]]

            afterLabekExpansion = pobjectStr
            afterLabekExpansion = re.sub("\n(" + ALLOWEDCOOBJNAMES + ":)", "\n" + pobject["name"] + ".\\1",
                                        pobjectStr)

            afterLocalCONameExpansion = afterLabekExpansion[:]
            jmpMnenmoncs = ["jal", "j", "beq", "bne", "bgt", "blt", "bltu", "bgtu", "bge", "ble"]

            for fname in pobject["allfns"]:
                for mnemonic in jmpMnenmoncs:
                    afterLocalCONameExpansion = re.sub("({0}\\s.*){1}".format(mnemonic, fname),
                                                    "\\1{0}.{1}".format(pobject["name"], fname),
                                                    afterLocalCONameExpansion)
            newcontents[pobject["hdrendpos"][0]] = newcontents[pobject["hdrendpos"][0]][
                                                    :pobject["hdrendpos"][1]] + afterLocalCONameExpansion + \
                                                    newcontents[pobject["endpos"][0]][(pobject["endpos"][1]):]

            advancepobjectRefs(pobject["endpos"][1], len(afterLocalCONameExpansion) - len(pobjectStr),
                                pobjects[(i):])
    return newcontents


def replaceCOFctReferences(contents, pobjects) -> []:
    newcontents = []

    replacements = []
    for pobject in pobjects:
        if pobject["type"] == "code":
            for func in pobject["publicfns"]:
                replacements.append(
                    ["(jlib.*)" + "@{0}.{1}".format(pobject["name"], func[0]), "\\1 " + str(func[1] * 4)])
                replacements.append(
                    ["(jalr.*)" + "@{0}.{1}".format(pobject["name"], func[0]), "\\1 " + str(func[1] * 4)])
                replacements.append(["(la.*)@({0})".format(pobject["name"]), "\\1\\2"])

    for content in contents:
        for replacement in replacements:
            content = re.sub(replacement[0], replacement[1], content)

        newcontents.append(content)

    return newcontents


def __main__() -> None:
    fileNames = sys.argv[1:]

    sourceFileContents = []
    sourceFileNames = []
    pobjectsFileName = None

    for fileName in fileNames:
        extension = "".join(fileName.split(".")[-1:])
        if extension == "s3":
            with open(fileName) as sourceFile:
                sourceFileContents.append("".join(sourceFile.readlines()))

            sourceFileNames.append(fileName)
        if extension == "pobs":
            pobjectsFileName = fileName

    try:
        pobjects = findCOs(sourceFileContents)
        doobj = findDOs(sourceFileContents)

        for do in doobj:
            for i, obj in enumerate(pobjects):
                if pobjects[i]["hdrstartpos"] > do["hdrstartpos"]:
                    pobjects.insert(i, do)
                    break

        pobjects = extractPublicFuncs(calcCOregions(pobjects, sourceFileContents),
                                         sourceFileContents)

        

        pobjects = extractAllFuncs(pobjects, sourceFileContents)

        #checkPubicFNExistance(pobjects)

        newContents = expandFunctionNames(sourceFileContents, pobjects)

        newContents = insertSectionEndLabels(newContents, pobjects)

        newContents = replaceCOHeaders(newContents, pobjects)

        newContents = replaceDataObjHeaders(newContents, pobjects)

        newContents = convertComments(newContents)

        newContents = applyMacros(newContents)

        newContents = replaceCOFctReferences(newContents, pobjects)
    except ParseException as e:
        details = e.args[0]
        lineNbr = sourceFileContents[details["fileIdx"]][:details["location"]].count("\n") + 1
        print(
            "Parse Error: {0} at line {1} in {2}".format(details["msg"], lineNbr, sourceFileNames[details["fileIdx"]]))
        exit()


    if pobjectsFileName is not None:
        with open(pobjectsFileName, "w") as pobjectsFile:
            pobjectsFile.write(str(pobjects))

    for i, newContent in enumerate(newContents):
        outFileName = "{0}.s".format("".join(sourceFileNames[i].split(".")[:-1]))
        with open(outFileName, "w") as outFile:
            outFile.write(HEADERMSG.format(sourceFileNames[i]))
            outFile.write(newContent)

    print("Preprocessed {} LOC".format(sum([x.count("\n") for x in sourceFileContents])))

if __name__ == "__main__":
    __main__()

