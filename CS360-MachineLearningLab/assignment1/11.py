""""Given an array of integers- [1,6,7,9],[7,9,3,5]
Write a program to print:
i. Dimension of the array
ii. Shape of the array
iii.Size of the array
"""
import numpy as np


array1 = np.array([1, 6, 7, 9])
array2 = np.array([7, 9, 3, 5])

print("Dimension of array1:", array1.ndim)
print("Dimension of array2:", array2.ndim)

print("Shape of array1:", array1.shape)
print("Shape of array2:", array2.shape)

print("Size of array1:", array1.size)
print("Size of array2:", array2.size)