#!/usr/bin/env python3
import sys

current_word = None

# Read each line from standard input
for line in sys.stdin:
    # Remove leading/trailing whitespace
    line = line.strip()

    if not line:
        continue  # Skip empty lines

    # Get the word from the line (we don't need the count here)
    word, _ = line.split('\t')

    # Only output the word if it's different from the previous word
    if word != current_word:
        print(word)
        current_word = word
