import numpy as np

# Sigmoid activation function
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# Derivative of the sigmoid function
def sigmoid_derivative(x):
    return x * (1 - x)

# Dataset
X = np.array([[1, 2],
              [0.2, 3],
              [4, 1],
              [6, 1]])
y = np.array([[1], [2], [2], [3]])

# Initialize weights and bias
np.random.seed(42)
weights = np.full((2, 1), 0.1)  # Initialize weights as 0.1
bias = 0.1  # Initialize bias as 0.1
learning_rate = 0.1
epochs = 2

# Training SLP
for epoch in range(epochs):
    print(f"Epoch {epoch + 1}")
    for i in range(X.shape[0]):
        # Forward pass
        inputs = X[i].reshape(1, -1)
        target = y[i]

        z = np.dot(inputs, weights) + bias
        output = sigmoid(z)

        # Backpropagation
        error = target - output
        weights += learning_rate * error * sigmoid_derivative(output) * inputs.T
        bias += learning_rate * error * sigmoid_derivative(output)

        print(f"Sample {i+1}: Predicted = {output.flatten()[0]:.4f}, Error = {error.flatten()[0]:.4f}")
    print("Updated Weights:", weights.flatten())
    print("Updated Bias:", bias)
    print()

# Predict class label for test sample [3, 0.1]
test_sample = np.array([3, 0.1])
z = np.dot(test_sample, weights) + bias
test_output = sigmoid(z)
predicted_class = round(test_output[0])

print(f"Predicted class label for test sample [3, 0.1]: {predicted_class}")
