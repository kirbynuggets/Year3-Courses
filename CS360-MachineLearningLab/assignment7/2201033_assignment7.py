import numpy as np
import math
from collections import Counter


# Euclidean distance calculation
def euclidean_distance(x1, x2):
    return np.sqrt(np.sum((x1 - x2) ** 2))


# K-NN Algorithm from Scratch
class KNN:
    def __init__(self, k=3):
        self.k = k

    def fit(self, X_train, y_train):
        self.X_train = X_train
        self.y_train = y_train

    def predict(self, X_test):
        predictions = [self._predict(x) for x in X_test]
        return np.array(predictions)

    def _predict(self, x):
        # Calculate the Euclidean distance between x and all data points in the training set
        distances = [euclidean_distance(x, x_train) for x_train in self.X_train]

        # Sort the distances and get the indices of the k closest neighbors
        k_indices = np.argsort(distances)[:self.k]

        # Get the labels of the k nearest neighbors
        k_nearest_labels = [self.y_train[i] for i in k_indices]

        # Return the most common class label among the neighbors
        most_common = Counter(k_nearest_labels).most_common(1)
        return most_common[0][0]


# Performance metrics: accuracy, precision, recall, F1 score
def accuracy(y_true, y_pred):
    return np.sum(y_true == y_pred) / len(y_true)


def precision(y_true, y_pred, positive_class):
    tp = np.sum((y_true == positive_class) & (y_pred == positive_class))
    fp = np.sum((y_true != positive_class) & (y_pred == positive_class))
    return tp / (tp + fp) if tp + fp > 0 else 0


def recall(y_true, y_pred, positive_class):
    tp = np.sum((y_true == positive_class) & (y_pred == positive_class))
    fn = np.sum((y_true == positive_class) & (y_pred != positive_class))
    return tp / (tp + fn) if tp + fn > 0 else 0


def f1_score(precision, recall):
    return 2 * (precision * recall) / (precision + recall) if precision + recall > 0 else 0


# Example: Using the Iris dataset (can be replaced with any other dataset)
from sklearn import datasets
from sklearn.model_selection import train_test_split

# Load the dataset
iris = datasets.load_iris()
X = iris.data
y = iris.target

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Initialize KNN with k = 3 (can experiment with different values of k)
k_value = 3
knn = KNN(k=k_value)
knn.fit(X_train, y_train)

# Make predictions
y_pred = knn.predict(X_test)

# Calculate performance metrics
acc = accuracy(y_test, y_pred)
prec = precision(y_test, y_pred, positive_class=1)  # Assume positive class is '1'
rec = recall(y_test, y_pred, positive_class=1)
f1 = f1_score(prec, rec)

# Output the results
print(f"Accuracy: {acc:.4f}")
print(f"Precision (Class 1): {prec:.4f}")
print(f"Recall (Class 1): {rec:.4f}")
print(f"F1 Score (Class 1): {f1:.4f}")
