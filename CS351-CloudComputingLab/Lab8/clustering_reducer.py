#!/usr/bin/env python3
import sys

current_candidate = None
sum_sepal_length = 0.0
sum_sepal_width = 0.0
count = 0

# Reading each line of input from the mapper output
for line in sys.stdin:
    line = line.strip()
    candidate_label, point_str = line.split("\t")
    sepal_length, sepal_width = map(float, point_str.split(","))

    # If we're still on the same candidate
    if candidate_label == current_candidate:
        sum_sepal_length += sepal_length
        sum_sepal_width += sepal_width
        count += 1
    else:
        # Output the average if we switch to a new candidate
        if current_candidate:
            avg_sepal_length = sum_sepal_length / count
            avg_sepal_width = sum_sepal_width / count
            print(f"{current_candidate}\t{avg_sepal_length},{avg_sepal_width}")

        # Reset for the new candidate
        current_candidate = candidate_label
        sum_sepal_length = sepal_length
        sum_sepal_width = sepal_width
        count = 1

# Output for the last candidate
if current_candidate:
    avg_sepal_length = sum_sepal_length / count
    avg_sepal_width = sum_sepal_width / count
    print(f"{current_candidate}\t{avg_sepal_length},{avg_sepal_width}")
