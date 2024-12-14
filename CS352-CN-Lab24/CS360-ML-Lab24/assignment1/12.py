"""Create two random arrays of any dimension and perform the following operations:
i. Concatenate two arrays.
ii. Sort both the arrays.
iii. Add the two arrays
iv. Subtract the two arrays
v. Multiply two arrays
vi. Divide the two arrays."""
import numpy as np

array1 = np.random.randint(1, 10, size=(2, 2))
array2 = np.random.randint(1, 10, size=(2, 2))

print("Array1:\n", array1)
print("Array2:\n", array2)

concatenated_array = np.concatenate((array1, array2), axis=1)
print("Concatenated Array:\n", concatenated_array)

sorted_array1 = np.sort(array1).reshape(array1.shape)
sorted_array2 = np.sort(array2).reshape(array2.shape)
print("Sorted Array1:\n", sorted_array1)
print("Sorted Array2:\n", sorted_array2)

added_arrays = np.add(array1, array2)
print("Added Arrays:\n", added_arrays)

subtracted_arrays = np.subtract(array1, array2)
print("Subtracted Arrays:\n", subtracted_arrays)

multiplied_arrays = np.multiply(array1, array2)
print("Multiplied Arrays:\n", multiplied_arrays)

with np.errstate(divide='ignore', invalid='ignore'):
    divided_arrays = np.divide(array1, array2)
    divided_arrays[np.isnan(divided_arrays)] = 0
print("Divided Arrays:\n", divided_arrays)
