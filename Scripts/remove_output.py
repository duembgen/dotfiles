#!/usr/bin/env python
# module REMOVE_OUTPUT
DESCRIPTION = \
'''
    Remove output cells from jupyter python notebook.
    Simplifies version control of jupyter notebooks.\n

    Usage: python remove_output.py notebook.ipynb
'''
import sys
import io
import os
import nbformat
from shutil import copyfile

import argparse


def remove_outputs(nb):
    for cell in nb.cells:
        if cell.cell_type == 'code':
            cell.outputs = []
            cell.execution_count = None

if __name__ == '__main__':
    # copy file
    parser = argparse.ArgumentParser(
        description = DESCRIPTION,
        epilog = "")
    parser.add_argument('filename', type=str, default='', help='name of jupyter notebook to be processed')
    args = parser.parse_args()

    fname = args.filename
    base, ext = os.path.splitext(fname)

    backup_ipynb = "{}_backup{}".format(base, ext)
    copyfile(fname, backup_ipynb)
    print("created backup", backup_ipynb)

    with io.open(fname, 'r') as f:
        nb = nbformat.read(f, nbformat.NO_CONVERT)

    remove_outputs(nb)
    with io.open(fname, 'w', encoding='utf8') as f:
        nbformat.write(nb, f)
    print("wrote", fname)
