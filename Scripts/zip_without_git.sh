#!/usr/bin/bash
zip -r $1 $2 -x $2/.git/**\* $2/.gitignore $2/Makefile **\*.log **\*.aux **\*.out
