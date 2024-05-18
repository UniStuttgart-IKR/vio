#!/usr/bin/env python
from argparse import ArgumentParser
import math

parser = ArgumentParser(description='A script to convert a .dat file to a .mif file, provided by LeyLux group')

parser.add_argument('infile', help='Input .dat file', metavar='INFILE')
parser.add_argument('outfile', help='Output .mif file', metavar='OUTFILE')

parser.add_argument('-d', '--depth', help="depth of .mif file", type=int, default=1024)
parser.add_argument('-p', '--pad', help="word to used for padding (not given -> no padding)", type=str, default="")
parser.add_argument('-w', '--width', help="width of an output word in bits", type=int, default=32)
parser.add_argument('-or', '--outradix', type=str, default="HEX")
parser.add_argument('-ir', '--inradix', help="radix of input file (ignored for binary files)", type=str, default="HEX")
parser.add_argument('-ar', '--addrradix', type=str, default="HEX")
args = parser.parse_args()

def radixStrToInt(s) -> int:
    if s == "HEX":
        return 16
    elif s == "DEC":
        return 10
    elif s == "OCT":
        return 8
    else:
        try:
            return int(s, base=10)
        except ValueError:
            print("unrecognised radix '{0}', exiting".format(s))
            exit(-1)
def toBase(number, base) -> str:
    res = ""
    base_chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    while number != 0:
        res += base_chars[number % base]
        number //= base

    return res[::-1] or "0"



def __main__(args) -> None:
    parsed_content = ''
    if args.infile.split(".")[:1] == "bin":
        with open(args.infile, 'r') as dat_content:
            for line in dat_content:
                parsed_content += bin(int(line, radixStrToInt(args.inradix)))[2:]
    else:
        with open(args.infile, 'rb') as bin_content:
                parsed_content = bin(int(bin_content.read().hex(), base=16))[2:]

    with open(args.outfile, 'w') as mif_file:
        mif_file.write('-- converted from {} using dat2mif by LeyLux group\n'.format(args.infile))
        mif_file.write('DEPTH = {};\n'.format(args.depth))
        mif_file.write('WIDTH = {};\n'.format(args.width))
        mif_file.write('ADDRESS_RADIX = {};\n'.format(args.addrradix))
        mif_file.write('DATA_RADIX = {};\n\n'.format(args.outradix))
        mif_file.write('CONTENT\n')
        mif_file.write('BEGIN\n')

        words_num = int(math.ceil((len(parsed_content)) / args.width))

        for word_index in range(0, words_num):
            word = int(parsed_content[(word_index*args.width):((word_index+1)*args.width)], base=2)
            mif_file.write('{0}: {1};\n'.format(toBase(word_index, radixStrToInt(args.addrradix)), toBase(word, radixStrToInt(args.outradix))))

        if args.pad != "":
            try:
                int(args.pad, base=radixStrToInt(args.outradix))
            except ValueError:
                print("WARNING: pad data '{0}' does not match radix ’{1}’".format(args.pad, args.outradix))

            mif_file.write('[{0}..{1}] : {2};\n'.format(toBase(words_num, radixStrToInt(args.addrradix)), toBase(args.depth, radixStrToInt(args.addrradix)), args.pad))

        mif_file.write("END;")


if __name__ == "__main__":
        __main__(args)