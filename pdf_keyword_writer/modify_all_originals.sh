#!/bin/bash

# Set the directory path where the PDF files are located
pdf_directory="./original"

# Check if the directory exists
if [ ! -d "$pdf_directory" ]; then
  echo "Error: The directory '$pdf_directory' does not exist."
  exit 1
fi

# Check if the modify_pdf.py script exists
if [ ! -f "./modify_pdf.py" ]; then
  echo "Error: The 'modify_pdf.py' script is missing in the current directory."
  exit 1
fi

# Get the name of the script without the path
script_name=$(basename "$0")

# Loop through each PDF file in the directory
for pdf_file in "$pdf_directory"/*.pdf; do
  if [ -f "$pdf_file" ]; then
    echo "$script_name: Processing: $pdf_file"
    ./modify_pdf.py conf/keywords.yaml "$pdf_file"
    echo "$script_name: Done processing: $pdf_file"
  else
    echo "$script_name: Warning: Skipping non-PDF file: $pdf_file"
  fi
done

echo "$script_name: All PDF files processed."
