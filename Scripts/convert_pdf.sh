#!/usr/bin/bash
find . -type f -name '*.pdf' -print0 |
  while IFS= read -r -d '' file
    # do convert -verbose -density 800 -resize 5000 "${file}" "${file%.*}.png"
    do convert -verbose -density 200 "${file}" "${file%.*}.png"
  done
