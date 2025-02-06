import numpy as np

# Dataset
X = np.array([2, 3, 4, 5, 6])
y = np.array([50, 60, 70, 80, 90])

# Parameters
m = 0  # slope
b = 0  # intercept
learning_rate = 0.01
iterations = 1000

# Gradient Descent
for _ in range(iterations):
    y_pred = m * X + b
    cost = (1/len(X)) * sum((y - y_pred)**2)
    dm = -(2/len(X)) * sum(X * (y - y_pred))
    db = -(2/len(X)) * sum(y - y_pred)
    m = m - learning_rate * dm
    b = b - learning_rate * db

print(f"Slope (m): {m}")
print(f"Intercept (b): {b}")
