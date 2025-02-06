"""Write a program to import excel data from the .csv file (generated in question 16) by
excluding the last row and last column."""

import pandas as pd  # Importing Pandas for handling data

# Reading the CSV file into a DataFrame
df = pd.read_csv('image_matrix.csv', header=None)

# Excluding the last row and last column
df_trimmed = df.iloc[:-1, :-1]

# Displaying the trimmed DataFrame
print("Data excluding the last row and last column:")
print(df_trimmed)
