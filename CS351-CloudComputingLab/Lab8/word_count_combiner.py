#!/usr/bin/env python3
import sys

current_word = None
current_count = 0

# Read each line from standard input
for line in sys.stdin:
    line = line.strip()
    word, count = line.split('\t')
    count = int(count)

    # If the current word matches the previous one, add up the counts
    if word == current_word:
        current_count += count
    else:
        # Output the count of the previous word
        if current_word:
            print(f"{current_word}\t{current_count}")
        # Update current_word and current_count
        current_word = word
        current_count = count

# Output the count for the last word if `current_word` is defined
if current_word:
    print(f"{current_word}\t{current_count}")
