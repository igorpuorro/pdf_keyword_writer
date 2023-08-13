#!/bin/bash

keyword_dump_script="./keyword_dump.sh"

# Check if keyword_dump.sh exists
if [ ! -f "$keyword_dump_script" ]; then
  echo "Error: $keyword_dump_script not found."
  exit 1
fi

# Check if the pdf_file argument is provided
if [ -z "$1" ]; then
  echo "Error: Please provide the PDF file as an argument."
  echo "Usage: $0 <pdf_file>"
  exit 1
fi

# Check if the pdf_file exists
if [ ! -f "$1" ]; then
  echo "Error: PDF file '$1' not found."
  exit 1
fi

# Run keyword_dump.sh passing the pdf_file argument
"$keyword_dump_script" "$1" | wc -l
