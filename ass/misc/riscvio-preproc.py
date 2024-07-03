import sys
import re

HEADERMSG = "# generated from {0} by riscvio-preproc.py by LeyLux Group\n"
ALLOWEDCOOBJNAMES = "[a-zA-Z0-9]+"
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
    codeObjects = []
    for i, content in enumerate(contents):
        COmatches = re.finditer("(@" + ALLOWEDCOOBJNAMES + "[>:])([\\S\n\t\v]*)private\n", content)

        for match in COmatches:
            codeObjects.append({
                "name": match.group(1).replace(">", "").replace(":", "").replace("@", ""),
                "super": ">" in match.group(1),
                "hdrstartpos": [i, match.span(1)[0] + 1],
                "hdrendpos": [i, match.span(2)[1]],
                "hdrfnstartpos": [i, match.span(1)[1]],
                "endpos": [-1, -1],
                "publicfns": [],
                "allfns": []
            })

    return codeObjects


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
        hdrfuncregion = contents[coobj["hdrfnstartpos"][0]][coobj["hdrfnstartpos"][1]:coobj["hdrendpos"][1]]

        funcnames = [x for x in hdrfuncregion.split("\n") if x != ""]

        if len(funcnames) == 0:
            raise ParseException({"msg": "Code object without public functions", "location": coobj["hdrfnstartpos"][1],
                                  "fileIdx": coobj["hdrfnstartpos"][0]})
        for i, funcname in enumerate(funcnames):
            coobj["publicfns"].append([funcname, i])

    return coobjectsnew


def extractAllFuncs(codeobjects, contents) -> [{}]:
    coobjectsnew = codeobjects[:]

    for i, coobj in enumerate(coobjectsnew):
        cofnregion = contents[coobj["hdrendpos"][0]][coobj["hdrendpos"][1]:coobj["endpos"][1]]
        #print(">" + cofnregion + "<")
        labelMatches = re.finditer("\n({}):".format(ALLOWEDFNEXPR), cofnregion)

        for match in labelMatches:
            coobj["allfns"].append(match.group(1))

    return coobjectsnew


def checkPubicFNExistance(codeobjects) -> None:
    for codeobject in codeobjects:
        for publfn in codeobject["publicfns"]:
            if publfn[0] not in [x[0] for x in codeobject["allfns"]]:
                raise ParseException(
                    {"msg": "Public funtion '{}' does not exist!".format(publfn[0]), "location": codeobject["hdrfnstartpos"][1],
                     "fileIdx": codeobject["hdrfnstartpos"][0]})


def advanceCodeObjectRefs(insertpos, insertlen, codeobjects):
    for i, codeobject in enumerate(codeobjects):
        for fieldname in ["hdrstartpos", "hdrendpos", "hdrfnstartpos", "endpos"]:
            if codeobjects[i][fieldname][1] >= insertpos:
                codeobjects[i][fieldname][1] += insertlen


def insertSectionEndLabels(contents, codeobjects) -> []:
    newcontents = contents[:]

    for codeobject in codeobjects:
        fileId = codeobject["endpos"][0]
        label = "\n{0}.end:\n\n\n".format(codeobject["name"])

        newcontents[fileId] = newcontents[fileId][:(codeobject["endpos"][1])] + label + newcontents[fileId][
                                                                                        (codeobject["endpos"][1]):]

        advanceCodeObjectRefs(codeobject["endpos"][1], len(label), codeobjects)
        pass

    return newcontents


def replaceCOHeaders(contents, codeobjects) -> [str]:
    newcontents = []

    hdrReplacements = []
    for codeobject in codeobjects:
        dstexpr = ""
        if codeobject["name"] != "core":
            dstexpr += ".align 3\n"
            
        if codeobject["super"]:
            srcexpr = "(@{}>)([\\S\n\t\v]*)private\n".format(codeobject["name"])
            dstexpr += '.section {0}, "xa"\n.word {0}.trampEnd - {0}.trampStart\n.word ({0}.end - {0}.trampStart - 4)\n\n{0}.trampStart:\n'.format(
                codeobject["name"])
        else:
            srcexpr = "(@{}:)([\\S\n\t\v]*)private\n".format(codeobject["name"])
            dstexpr += '.section {0}, "xa"\n.word {0}.trampEnd - {0}.trampStart\n.word {0}.end - {0}.trampStart - 4\n\n{0}.trampStart:\n'.format(
                codeobject["name"])

        for fct in codeobject["publicfns"]:
            dstexpr += "{0}.{1}_: j {0}.{1}\n".format(codeobject["name"], fct[0])

        dstexpr += "{0}.trampEnd:\n\n".format(codeobject["name"])

        hdrReplacements.append([srcexpr, dstexpr])

    for content in contents:
        for hdrReplacement in hdrReplacements:
            content = re.sub(hdrReplacement[0], hdrReplacement[1], content)

        newcontents.append(content)

    return newcontents


def expandFunctionNames(contents, codeobjects) -> []:
    newcontents = contents[:]

    for i, codeobject in enumerate(codeobjects):
        codeobjectStr = newcontents[codeobject["hdrendpos"][0]][codeobject["hdrendpos"][1]:codeobject["endpos"][1]]

        afterLabekExpansion = codeobjectStr
        afterLabekExpansion = re.sub("\n(" + ALLOWEDCOOBJNAMES + ":)", "\n" + codeobject["name"] + ".\\1",
                                    codeobjectStr)

        afterLocalCONameExpansion = afterLabekExpansion[:]
        jmpMnenmoncs = ["jal", "j", "beq", "bne", "bgt", "blt", "bltu", "bgtu", "bge", "ble"]

        for fname in codeobject["allfns"]:
            for mnemonic in jmpMnenmoncs:
                afterLocalCONameExpansion = re.sub("({0}\\s.*){1}".format(mnemonic, fname),
                                                   "\\1{0}.{1}".format(codeobject["name"], fname),
                                                   afterLocalCONameExpansion)
        newcontents[codeobject["hdrendpos"][0]] = newcontents[codeobject["hdrendpos"][0]][
                                                  :codeobject["hdrendpos"][1]] + afterLocalCONameExpansion + \
                                                  newcontents[codeobject["endpos"][0]][(codeobject["endpos"][1]):]

        advanceCodeObjectRefs(codeobject["endpos"][1], len(afterLocalCONameExpansion) - len(codeobjectStr),
                              codeobjects[(i):])
    return newcontents


def replaceCOFctReferences(contents, codeobjects) -> []:
    newcontents = []

    replacements = []
    for codeobject in codeobjects:
        for func in codeobject["publicfns"]:
            replacements.append(
                ["(jlib.*)" + "@{0}.{1}".format(codeobject["name"], func[0]), "\\1 " + str(func[1] * 4)])
            replacements.append(
                ["(jalr.*)" + "@{0}.{1}".format(codeobject["name"], func[0]), "\\1 " + str(func[1] * 4)])
            replacements.append(["(la.*)@({0})".format(codeobject["name"]), "\\1\\2"])

    for content in contents:
        for replacement in replacements:
            content = re.sub(replacement[0], replacement[1], content)

        newcontents.append(content)

    return newcontents


def __main__() -> None:
    fileNames = sys.argv[1:]

    sourceFileContents = []
    sourceFileNames = []
    codeObjectsFileName = None

    for fileName in fileNames:
        extension = "".join(fileName.split(".")[-1:])
        if extension == "s3":
            with open(fileName) as sourceFile:
                sourceFileContents.append("".join(sourceFile.readlines()))

            sourceFileNames.append(fileName)
        if extension == "pobs":
            codeObjectsFileName = fileName

    try:
        codeObjects = extractPublicFuncs(calcCOregions(findCOs(sourceFileContents), sourceFileContents),
                                         sourceFileContents)

        codeObjects = extractAllFuncs(codeObjects, sourceFileContents)

        #checkPubicFNExistance(codeObjects)

        newContents = expandFunctionNames(sourceFileContents, codeObjects)

        newContents = insertSectionEndLabels(newContents, codeObjects)

        newContents = replaceCOHeaders(newContents, codeObjects)

        newContents = convertComments(newContents)

        newContents = applyMacros(newContents)

        newContents = replaceCOFctReferences(newContents, codeObjects)


    except ParseException as e:
        details = e.args[0]
        lineNbr = sourceFileContents[details["fileIdx"]][:details["location"]].count("\n") + 1
        print(
            "Parse Error: {0} at line {1} in {2}".format(details["msg"], lineNbr, sourceFileNames[details["fileIdx"]]))
        exit()


    if codeObjectsFileName is not None:
        with open(codeObjectsFileName, "w") as codeObjectsFile:
            codeObjectsFile.write(str(codeObjects))

    for i, newContent in enumerate(newContents):
        outFileName = "{0}.s".format("".join(sourceFileNames[i].split(".")[:-1]))
        with open(outFileName, "w") as outFile:
            outFile.write(HEADERMSG.format(sourceFileNames[i]))
            outFile.write(newContent)

    print("Preprocessed {} LOC".format(sum([x.count("\n") for x in sourceFileContents])))

if __name__ == "__main__":
    __main__()

