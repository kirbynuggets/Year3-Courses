"""Write a python program to read an image and save the image as a matrix to a .csv file
using pandas."""

import cv2  # Importing OpenCV for image processing
import pandas as pd  # Importing Pandas for handling data
import numpy as np  # Importing NumPy for handling arrays

# Reading the image using OpenCV
image = cv2.imread('OLYMPICS.png', cv2.IMREAD_GRAYSCALE)

# Converting the image to a matrix (2D array)
image_matrix = np.array(image)

# Creating a DataFrame from the image matrix
df = pd.DataFrame(image_matrix)

# Saving the DataFrame to a CSV file
df.to_csv('image_matrix.csv', index=False, header=False)

print("Image saved as matrix to 'image_matrix.csv'")
