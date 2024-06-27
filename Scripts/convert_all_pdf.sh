#!/usr/bin/bash
for file in "$@" ; do
  echo "converting ${file} to ${file%.*}.png"
  convert -verbose -density 300 -trim "${file}" -quality 100 -flatten -sharpen 0x1.0 "${file%.*}".png
  echo "done"
done
echo "done"
