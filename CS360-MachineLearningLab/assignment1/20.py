import pandas as pd
import numpy as np
from scipy import stats

# Read the dataset
data = pd.read_csv('salary_data.csv')  # Replace 'dataset.csv' with your actual file path

# Row-wise calculations
row_mean = data.mean(axis=1)
row_median = data.median(axis=1)
row_mode = row_mode = data.apply(lambda x: stats.mode(x)[0], axis=1)
row_std = data.std(axis=1)

# Column-wise calculations
col_mean = data.mean()
col_median = data.median()
col_mode = data.apply(lambda x: stats.mode(x)[0])
col_std = data.std()

# Overall calculations
overall_mean = data.values.mean()
overall_median = np.median(data.values)
overall_mode = stats.mode(data.values.flatten())[0]
overall_std = data.values.std()

# Print results
print("Row-wise Mean:\n", row_mean)
print("Row-wise Median:\n", row_median)
print("Row-wise Mode:\n", row_mode)
print("Row-wise Standard Deviation:\n", row_std)

print("\nColumn-wise Mean:\n", col_mean)
print("\nColumn-wise Median:\n", col_median)
print("\nColumn-wise Mode:\n", col_mode)
print("\nColumn-wise Standard Deviation:\n", col_std)

print("\nOverall Mean:", overall_mean)
print("Overall Median:", overall_median)
print("Overall Mode:", overall_mode)
print("Overall Standard Deviation:", overall_std)
