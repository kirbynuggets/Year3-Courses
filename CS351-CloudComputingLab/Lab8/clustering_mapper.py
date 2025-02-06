#!/usr/bin/env python3
import sys
import math

# Hardcoded candidate points: Only using sepal length and sepal width
candidates = [
    ("C1", (5.8, 4.0)),  # Candidate for Iris-setosa
    ("C2", (6.1, 2.8)),  # Candidate for Iris-versicolor
    ("C3", (6.3, 2.7))  # Candidate for Iris-virginica
]


def euclidean_distance(point1, point2):
    return math.sqrt((point1[0] - point2[0]) ** 2 + (point1[1] - point2[1]) ** 2)


# Reading each line of input data
for line in sys.stdin:
    line = line.strip()
    parts = line.split(",")

    # Extract sepal length and sepal width
    try:
        sepal_length = float(parts[0])
        sepal_width = float(parts[1])
        point = (sepal_length, sepal_width)
    except ValueError:
        continue  # Skip lines with invalid data

    # Find the nearest candidate point
    nearest_candidate = None
    min_distance = float("inf")

    for candidate_label, candidate_point in candidates:
        distance = euclidean_distance(point, candidate_point)
        if distance < min_distance:
            min_distance = distance
            nearest_candidate = candidate_label

    # Emit the nearest candidate label and point
    if nearest_candidate:
        print(f"{nearest_candidate}\t{sepal_length},{sepal_width}")
