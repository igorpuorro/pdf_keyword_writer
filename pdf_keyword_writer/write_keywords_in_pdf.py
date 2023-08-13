#!/usr/bin/env python3

import os
import sys
import shutil
import re
import yaml
import PyPDF2
from PyPDF2.pdf import PageObject
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from io import BytesIO

def read_yaml_config(config_file):
    with open(config_file, 'r') as file:
        return yaml.safe_load(file)

def create_invisible_watermark(c, text):
    c.saveState()
    c.setStrokeColorRGB(0, 0, 0, 0)  # Set the stroke color to transparent
    c.setFillGray(1.0)  # Set the fill color to white

    # Calculate the position for bottom right alignment
    text_width = c.stringWidth(text, "Helvetica", 1)
    text_height = c._fontsize  # Use the correct attribute name '_fontsize'
    page_width, page_height = letter
    x = page_width - text_width - 1 # 100 units margin from the right edge
    y = text_height + 1 # 100 units margin from the bottom edge

    c.setFont("Helvetica", 1)
    c.drawString(x, y, f"{text}. ")
    c.restoreState()

def write_keywords_in_pdf(pdf_file, keywords, output_file):
    with open(pdf_file, 'rb') as file:
        pdf_reader = PyPDF2.PdfFileReader(file)
        pdf_writer = PyPDF2.PdfFileWriter()

        c = canvas.Canvas("temp_canvas.pdf", pagesize=letter)
        for keyword in keywords:
            create_invisible_watermark(c, keyword)

        c.save()

        temp_pdf = PyPDF2.PdfFileReader("temp_canvas.pdf")
        num_pages = min(pdf_reader.getNumPages(), temp_pdf.getNumPages())

        for page_num in range(num_pages):
            page = pdf_reader.getPage(page_num)
            temp_page = temp_pdf.getPage(page_num)

            page.mergePage(temp_page)
            pdf_writer.addPage(page)

        for page_num in range(num_pages, pdf_reader.getNumPages()):
            pdf_writer.addPage(pdf_reader.getPage(page_num))

        with open(output_file, 'wb') as output:
            pdf_writer.write(output)

    os.remove("temp_canvas.pdf")

def main():
    if len(sys.argv) != 4:
        print("Usage: python script.py <yaml_config_file> <pdf_file> <output_file>")
        sys.exit(1)

    yaml_config_file = sys.argv[1]
    pdf_file = sys.argv[2]
    output_file = sys.argv[3]

    config = read_yaml_config(yaml_config_file)
    keywords = config.get('keywords', [])

    num_keywords = len(keywords) if keywords else 0

    script_name = os.path.basename(__file__)

    write_keywords_in_pdf(pdf_file, keywords, output_file)
    print(f"{script_name}: Modified PDF with {num_keywords} invisible keywords saved as {output_file}")

if __name__ == "__main__":
    main()
