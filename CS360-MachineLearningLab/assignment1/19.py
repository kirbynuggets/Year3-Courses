import pandas as pd
from sklearn.model_selection import train_test_split

# Read the dataset
data = pd.read_csv('salary_data.csv')  # Replace 'dataset.csv' with your actual file path

# Print number of features, number of patterns, range of output
print("Number of features:", len(data.columns))
print("Number of patterns:", len(data))
print("Range of output (Salary):", data['Salary'].min(), "-", data['Salary'].max())

# Splitting the dataset according to given ratios X:Y where X+Y=100%
for x in range(10, 91, 10):
    y = 100 - x
    X_train, X_test, y_train, y_test = train_test_split(data.drop('Salary', axis=1),
                                                        data['Salary'],
                                                        test_size=y/100.0,
                                                        random_state=42)
    print(f"Split ratio {x}:{y} - Training set: {len(X_train)} samples; Test set: {len(X_test)} samples")
