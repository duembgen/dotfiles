#! /usr/bin/env python
# -*- coding: utf-8 -*-

DESCRIPTION = \
"""
    Show version of python package.

    Usage: python show_version.py package
"""
if __name__ == '__main__':
    import argparse
    import importlib
    parser = argparse.ArgumentParser(
        description = DESCRIPTION,
        epilog = "")
    parser.add_argument('package', type=str, default='', help='name of python package')
    args = parser.parse_args()

    name = args.package
    
    mod = importlib.import_module(name)
    print(mod.__version__)
