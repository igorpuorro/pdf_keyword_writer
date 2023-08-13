#!/usr/bin/env python3

import os
import sys
import subprocess

def main():
    # Check if the correct number of arguments is provided
    if len(sys.argv) != 3:
        print("Usage: python {} <yaml_config_file> <pdf_file>".format(sys.argv[0]))
        sys.exit(1)

    yaml_config_file = sys.argv[1]
    pdf_file = sys.argv[2]

    # Get the filename from the pdf_file argument
    pdf_filename = os.path.basename(pdf_file)

    # Create the modified directory if it doesn't exist
    modified_dir = "modified"
    if not os.path.exists(modified_dir):
        os.makedirs(modified_dir)

    # Construct the output path for the modified file
    modified_pdf_path = os.path.join(modified_dir, pdf_filename)

    script_name = os.path.basename(__file__)

    try:
        # Get the path to the Python interpreter currently running the script
        python_interpreter = sys.executable
        # Run the write_keywords_in_pdf.py script with the specified arguments
        subprocess.check_call([python_interpreter, 'write_keywords_in_pdf.py', yaml_config_file, pdf_file, modified_pdf_path])
        print(f"{script_name}: Modified PDF file created successfully at: {modified_pdf_path}")
    except subprocess.CalledProcessError:
        print(f"{script_name}: An error occurred while running the script.")
        sys.exit(1)

if __name__ == "__main__":
    main()
