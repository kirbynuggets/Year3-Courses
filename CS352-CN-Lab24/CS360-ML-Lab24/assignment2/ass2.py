import numpy as np
import pandas as pd

np.random.seed(42)

hours_of_sunshine = np.random.randint(1, 12, 30)
ice_creams_sold = hours_of_sunshine * np.random.randint(3, 6, 30) + np.random.randint(-3, 4, 30)

data = pd.DataFrame({
    'Hours of Sunshine': hours_of_sunshine,
    'Ice Creams Sold': ice_creams_sold
})

print("First five rows of the dataset:")
print(data.head())

print("\nTotal number of rows and columns:")
print(data.shape)

print("\nRange of each feature's values:")
print(data.agg([min, max]))

def split_dataset(data, train_ratio):
    data = data.sample(frac=1).reset_index(drop=True)
    train_size = int(len(data) * train_ratio)
    train_set = data[:train_size]
    test_set = data[train_size:]
    return train_set, test_set

def simple_linear_regression(train_set):
    X_train = train_set['Hours of Sunshine'].values
    Y_train = train_set['Ice Creams Sold'].values
    
    X_mean = np.mean(X_train)
    Y_mean = np.mean(Y_train)
    
    numerator = np.sum((X_train - X_mean) * (Y_train - Y_mean))
    denominator = np.sum((X_train - X_mean) ** 2)
    b1 = numerator / denominator
    b0 = Y_mean - b1 * X_mean
    
    return b0, b1

def predict(b0, b1, X):
    return b0 + b1 * X

def mean_squared_error(y_true, y_pred):
    return np.mean((y_true - y_pred) ** 2)

ratios = [0.7, 0.8, 0.9]

best_ratio = None
best_mse = float('inf')

for ratio in ratios:
    train_set, test_set = split_dataset(data, ratio)
    b0, b1 = simple_linear_regression(train_set)
    
    X_test = test_set['Hours of Sunshine'].values
    Y_test = test_set['Ice Creams Sold'].values
    Y_pred = predict(b0, b1, X_test)
    mse = mean_squared_error(Y_test, Y_pred)
    
    print(f"\nMSE for {int(ratio*100)}-{int((1-ratio)*100)} split: {mse}")
    
    if mse < best_mse:
        best_mse = mse
        best_ratio = ratio

print(f"\nBest split ratio is {int(best_ratio*100)}-{int((1-best_ratio)*100)} with MSE: {best_mse}")
