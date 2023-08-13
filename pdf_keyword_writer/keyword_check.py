#!/usr/bin/env python3

import os
import sys
import subprocess
import yaml
import re

def check_files_exist(yaml_config_file, pdf_file):
    if not os.path.exists(yaml_config_file):
        print(f"Error: YAML config file '{yaml_config_file}' not found.")
        sys.exit(1)

    if not os.path.exists(pdf_file):
        print(f"Error: PDF file '{pdf_file}' not found.")
        sys.exit(1)

def read_keywords_from_yaml(yaml_config_file):
    with open(yaml_config_file, "r") as file:
        config_data = yaml.safe_load(file)
        if "keywords" not in config_data:
            print("Error: 'keywords' not found in the YAML config file.")
            sys.exit(1)
        return config_data["keywords"]

def run_keyword_dump(pdf_file):
    try:
        output = subprocess.check_output(["./keyword_dump.sh", pdf_file], text=True)
        return output.strip().split("\n")
    except subprocess.CalledProcessError:
        print("Error running keyword_dump.sh. Make sure the script is executable.")
        sys.exit(1)

def main():
    if len(sys.argv) != 3:
        print("Usage: python keyword_check.py <yaml_config_file> <pdf_file>")
        sys.exit(1)

    yaml_config_file = sys.argv[1]
    pdf_file = sys.argv[2]

    check_files_exist(yaml_config_file, pdf_file)
    keywords = read_keywords_from_yaml(yaml_config_file)
    keyword_data = run_keyword_dump(pdf_file)

    for keyword in keywords:
        found = any(re.search(r"\b" + re.escape(keyword) + r"\b", element, re.IGNORECASE) for element in keyword_data)
        print(f"{keyword}: {'Found' if found else 'Not found'}")

if __name__ == "__main__":
    main()
