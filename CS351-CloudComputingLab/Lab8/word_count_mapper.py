#!/usr/bin/env python3
import sys
import re

punctuation_pattern = re.compile(r'[^\w\s]')

# Read each line from standard input
for line in sys.stdin:
    # Remove leading/trailing whitespace
    line = line.strip()
    # Remove punctuation and convert to lowercase
    line = punctuation_pattern.sub('', line).lower()
    # Split the line into words
    words = line.split()
    # Output each word with a count of 1
    for word in words:
        print(f"{word}\t1")
