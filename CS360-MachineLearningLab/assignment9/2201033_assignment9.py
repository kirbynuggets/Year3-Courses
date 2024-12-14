import numpy as np


# Sigmoid activation function and its derivative
def sigmoid(x):
    return 1 / (1 + np.exp(-x))


def sigmoid_derivative(x):
    return x * (1 - x)


# Function to initialize weights and biases
def initialize_parameters(input_size, hidden_size, output_size):
    np.random.seed(42)
    weights_input_hidden = np.random.rand(input_size, hidden_size)  # Weights between input and hidden layer
    weights_hidden_output = np.random.rand(hidden_size, output_size)  # Weights between hidden and output layer
    bias_hidden = np.random.rand(1, hidden_size)  # Bias for hidden layer
    bias_output = np.random.rand(1, output_size)  # Bias for output layer
    return weights_input_hidden, weights_hidden_output, bias_hidden, bias_output


# Training the neural network
def train_neural_network(X, Y, epochs=30, learning_rate=0.1):
    input_size = X.shape[1]  # Number of features (columns) in input
    hidden_size = 2  # Number of hidden neurons (as per the problem statement)
    output_size = Y.shape[1]  # Number of output neurons (2 in this case)

    # Initialize parameters
    weights_input_hidden, weights_hidden_output, bias_hidden, bias_output = initialize_parameters(input_size,
                                                                                                  hidden_size,
                                                                                                  output_size)

    # Training loop
    for epoch in range(epochs):
        # Forward Pass
        hidden_input = np.dot(X, weights_input_hidden) + bias_hidden
        hidden_output = sigmoid(hidden_input)  # Activation of hidden layer

        output_input = np.dot(hidden_output, weights_hidden_output) + bias_output
        predicted_output = sigmoid(output_input)  # Activation of output layer

        # Compute the error (Mean Squared Error)
        error = Y - predicted_output
        mse = np.mean(np.square(error))

        # Backward Pass (Backpropagation)
        output_error_term = error * sigmoid_derivative(predicted_output)
        hidden_error_term = np.dot(output_error_term, weights_hidden_output.T) * sigmoid_derivative(hidden_output)

        # Update weights and biases using gradient descent
        weights_hidden_output += np.dot(hidden_output.T, output_error_term) * learning_rate
        weights_input_hidden += np.dot(X.T, hidden_error_term) * learning_rate
        bias_output += np.sum(output_error_term, axis=0, keepdims=True) * learning_rate
        bias_hidden += np.sum(hidden_error_term, axis=0, keepdims=True) * learning_rate

        # Print the MSE at each epoch to track progress
        if epoch % 5 == 0:
            print(f"Epoch {epoch + 1}/{epochs}, Mean Squared Error (MSE): {mse:.4f}")

    # Return final output after training
    return predicted_output


# Main function to run the neural network
def main():
    # Dataset (4 examples)
    X = np.array([[0, 0], [0, 1], [1, 0], [1, 1]])  # Input features
    Y = np.array([[0, 0], [1, 1], [1, 1], [0, 0]])  # Target values

    # Display dataset
    print("Training Dataset:")
    print("Input1, Input2 | Target (Y)")
    for i in range(len(X)):
        print(f"{X[i]} | {Y[i]}")

    # Get user input for number of epochs and learning rate
    epochs = int(input("\nEnter the number of epochs (default 30): ") or 30)
    learning_rate = float(input("Enter the learning rate (default 0.1): ") or 0.1)

    # Train the neural network
    print("\nTraining the neural network...")
    final_output = train_neural_network(X, Y, epochs=epochs, learning_rate=learning_rate)

    # Display final output
    print("\nFinal Output after training:")
    print(final_output)

    print("\nTraining Complete! The network has been trained for {} epochs.".format(epochs))


# Run the program
if __name__ == "__main__":
    main()
