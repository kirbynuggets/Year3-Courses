"""Create a random matrix of 10 x 5 (where columns are the features and rows are the patterns) and 
find the maximum and minimum values from each feature."""

import numpy as np

matrix1 = np.random.randint(1,10, size = (10, 5))

max1 = np.max(matrix1, axis = 0)
min1 = np.min(matrix1, axis = 0)

print("original matrix:\n", matrix1)
print("max. values of features:\n", max1)
print("min. values of features:\n", min1)