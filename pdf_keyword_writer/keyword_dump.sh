#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <pdf_file>"
  exit 1
fi

pdf_file="$1"

# Check if the PDF file exists
if [ ! -f "$pdf_file" ]; then
  echo "Error: $pdf_file not found."
  exit 1
fi

# Run the Python command and extract the desired information
/usr/bin/env python3 ./pdf_text_extractor.py "$pdf_file" -l 1000 | \
    grep '^[A-Za-z]\+' | \
    sed -E 's/\.([^\.]*|$)/\n\1/g' | \
    sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | \
    grep -v '^$' | \
    grep -v '^.$'
