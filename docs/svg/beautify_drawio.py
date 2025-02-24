import re
import os

drawiofiles = [f for f in os.listdir() if ".drawio.svg" in f]
replacements = [['content=".+?"', ""], ['xlink:href=".+?"', ""]]

for file in drawiofiles:
    filehandle = open(file)
    fc_cont = "".join(filehandle.readlines())
    filehandle.close()

    for repl in replacements:
        fc_cont = re.sub(repl[0], repl[1], fc_cont)

    with open(file, "w") as new_filehandle:
        new_filehandle.write(fc_cont)

