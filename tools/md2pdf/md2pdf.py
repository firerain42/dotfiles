#!/usr/bin/env python3
from optparse import OptionParser
import os.path
import subprocess


def main():
    parser = OptionParser(usage='usage: %prog [options] MD_FILE')
    parser.add_option("-o", "--output", dest="output",
            help="write the resulting pdf to FILE. [default: MD_FILE.pdf]", metavar="FILE")

    (options, args) = parser.parse_args()

    if len(args) != 1:
        parser.print_usage()
        exit(1)

    input_file = args[0]
    if not os.path.exists(input_file) or not os.path.isfile(input_file):
        print('{} does not exist or is not a file.'.format(input_file))
        exit(1)

    output_file = options.output
    if output_file is None:
        output_file= input_file + '.pdf'

    script_dir = os.path.dirname(os.path.realpath(__file__)) + '/default.latex'

    subprocess.run(['pandoc', '--latex-engine=xelatex', '-Vdocumentclass=scrartcl', '--template=' + script_dir, '-o', output_file, input_file])




if __name__ == '__main__':
    main()
