#!/usr/bin/env python3
import sys
import re

# Regular expression to match any character that is not a letter, number, or space
punctuation_pattern = re.compile(r'[^\w\s]')

# Specify the input file name
input_file = "inputfile.txt"  # Replace this if the filename differs

# Open the input file and read line by line
with open(input_file, 'r') as infile:
    for line in infile:
        # Remove leading and trailing whitespace
        line = line.strip()

        # Remove punctuation and convert to lowercase
        line = punctuation_pattern.sub('', line).lower()

        # Split the line into words
        words = line.split()

        # Output each word with a count of 1
        for word in words:
            print(f"{word}\t1")