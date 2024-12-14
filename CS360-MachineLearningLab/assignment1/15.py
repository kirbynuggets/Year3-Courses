"""Create a random matrix of size 10 x 5 (where columns are the features and rows are the
patterns) and find the number of patterns having the same ith feature (i=1,2,...number of
features).
"""
import numpy as np

matrix = np.random.randint(0, 10, size=(10, 5))

print("Matrix:")
print(matrix)

def count_patterns(matrix):
    num_patterns, num_features = matrix.shape
    counts = np.zeros((num_features, 10), dtype=int)

    for feature in range(num_features):
        values = matrix[:, feature]
        unique, counts_per_value = np.unique(values, return_counts=True)
        for value, count in zip(unique, counts_per_value):
            counts[feature, value] = count

    return counts

feature_counts = count_patterns(matrix)

print("\nCounts of patterns with the same value for each feature:")
for i, counts in enumerate(feature_counts):
    print(f"Feature {i+1}: {counts}")

