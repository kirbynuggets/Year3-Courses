"""Write a NumPy program
i. Create a 4 x 5 matrix with values ranging from 1 to 10, also find the transpose of the matrix.
ii. Create an array of 10 zeros,10 ones, 10 fives.
iii. Create an array of all the even integers from 10 to 50.
iv. Generate a random number between 0 and 1.
v. Save the matrix (generated in question iv) to a text file and load"""

import numpy as np

matrix1 = np.random.randint(1,10, size = (4, 5))

trans_matrix1 = np.matrix_transpose(matrix1)

print("Original matrix:\n", matrix1)
print("Transposed_matrix:\n", trans_matrix1)

