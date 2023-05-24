#!/usr/bin/bash
convert -verbose -density "${3-200}" -trim "$1" -quality 100 -flatten -sharpen 0x1.0 "$2"
