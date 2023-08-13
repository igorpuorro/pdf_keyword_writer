#!/usr/bin/env python3

import sys
from pdfminer.high_level import extract_text

def print_words_from_pdf(pdf_file_path, word_limit):
    try:
        # Extract text from the PDF file
        text = extract_text(pdf_file_path)

        # Split the text into words
        words = text.split()

        # Initialize variables
        words_printed = 0

        # Print each word
        for word in words:
            print(word, end='\n')
            words_printed += 1

            # Check if the word limit is reached
            if words_printed >= word_limit:
                print()
                return

    except FileNotFoundError:
        print(f"Error: PDF file '{pdf_file_path}' not found.")

def print_lines_from_pdf(pdf_file_path, line_limit):
    try:
        # Extract text from the PDF file
        text = extract_text(pdf_file_path)

        # Split the text into lines
        lines = text.split('\n')

        # Print each line
        for line in lines[:line_limit]:
            print(line)

    except FileNotFoundError:
        print(f"Error: PDF file '{pdf_file_path}' not found.")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script_name.py <PDF_File_Path> <-c|-l> <Word/Line_Limit>")
    else:
        pdf_file_path = sys.argv[1]
        option = sys.argv[2]
        limit = int(sys.argv[3])

        if option == '-c':
            print_words_from_pdf(pdf_file_path, limit)
        elif option == '-l':
            print_lines_from_pdf(pdf_file_path, limit)
        else:
            print("Invalid option. Use -c for word printing or -l for line printing.")
