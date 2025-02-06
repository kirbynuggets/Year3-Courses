import numpy as np
import pandas as pd
from collections import Counter
import math
from sklearn.metrics import confusion_matrix

np.random.seed(42)

data = {
    'Age': np.random.randint(20, 80, 21),
    'Blood_Pressure': np.random.choice(['High', 'Low', 'Normal'], 21),
    'Symptoms_Present': np.random.choice(['Yes', 'No'], 21),
    'Family_History': np.random.choice(['Yes', 'No'], 21),
    'Test_Result_Level': np.random.choice(['High', 'Medium', 'Low'], 21),
    'Illness': np.random.choice(['Yes', 'No'], 21)
}

df = pd.DataFrame(data)
print(df)

df['Blood_Pressure'] = df['Blood_Pressure'].map({'High': 2, 'Normal': 1, 'Low': 0})
df['Symptoms_Present'] = df['Symptoms_Present'].map({'Yes': 1, 'No': 0})
df['Family_History'] = df['Family_History'].map({'Yes': 1, 'No': 0})
df['Test_Result_Level'] = df['Test_Result_Level'].map({'High': 2, 'Medium': 1, 'Low': 0})
df['Illness'] = df['Illness'].map({'Yes': 1, 'No': 0})

def entropy(y):
    counts = np.bincount(y)
    probabilities = counts / len(y)
    return -np.sum([p * math.log2(p) for p in probabilities if p > 0])

def information_gain(y, split_indices):
    parent_entropy = entropy(y)
    n = len(y)
    weighted_avg_entropy = sum((len(split) / n) * entropy(y[split]) for split in split_indices)
    return parent_entropy - weighted_avg_entropy

class DecisionTree:
    def __init__(self, depth=0, max_depth=3):
        self.depth = depth
        self.max_depth = max_depth
        self.feature = None
        self.threshold = None
        self.left = None
        self.right = None
        self.value = None

    def fit(self, X, y):
        if len(set(y)) == 1:
            self.value = y[0]
            return

        if self.depth >= self.max_depth:
            self.value = Counter(y).most_common(1)[0][0]
            return

        n_samples, n_features = X.shape
        best_gain = -1
        split = None

        for feature in range(n_features):
            values = X[:, feature]
            thresholds = np.unique(values)
            for threshold in thresholds:
                left_indices = np.where(values <= threshold)[0]
                right_indices = np.where(values > threshold)[0]
                if len(left_indices) > 0 and len(right_indices) > 0:
                    gain = information_gain(y, [left_indices, right_indices])
                    if gain > best_gain:
                        best_gain = gain
                        self.feature = feature
                        self.threshold = threshold
                        split = (left_indices, right_indices)

        if best_gain == -1:
            self.value = Counter(y).most_common(1)[0][0]
            return

        left_indices, right_indices = split
        self.left = DecisionTree(self.depth + 1, self.max_depth)
        self.right = DecisionTree(self.depth + 1, self.max_depth)
        self.left.fit(X[left_indices, :], y[left_indices])
        self.right.fit(X[right_indices, :], y[right_indices])

    def predict(self, X):
        if self.value is not None:
            return self.value
        feature_value = X[self.feature]
        if feature_value <= self.threshold:
            return self.left.predict(X)
        else:
            return self.right.predict(X)

    def print_tree(self, feature_names, indent=""):
        if self.value is not None:
            print(indent + "Predict:", self.value)
        else:
            print(indent + f"Feature {feature_names[self.feature]} <= {self.threshold}")
            print(indent + "Left:")
            self.left.print_tree(feature_names, indent + "  ")
            print(indent + "Right:")
            self.right.print_tree(feature_names, indent + "  ")

X = df.drop(columns=['Illness']).values
y = df['Illness'].values

train_size = int(0.8 * len(X))
X_train, X_test = X[:train_size], X[train_size:]
y_train, y_test = y[:train_size], y[train_size:]

tree = DecisionTree(max_depth=3)
tree.fit(X_train, y_train)

y_pred = np.array([tree.predict(x) for x in X_test])

patient = np.array([25, 1, 1, 0, 2])
patient_prediction = tree.predict(patient)
print("Prediction for patient (25 years, High BP, Symptoms Present, No Family History, High Test Result):", "Yes" if patient_prediction == 1 else "No")

accuracy = np.sum(y_pred == y_test) / len(y_test)
print(f"Test Accuracy: {accuracy * 100:.2f}%")

conf_matrix = confusion_matrix(y_test, y_pred)
print("Confusion Matrix:\n", conf_matrix)

train_pred = np.array([tree.predict(x) for x in X_train])
train_accuracy = np.sum(train_pred == y_train) / len(y_train)
print(f"Training Accuracy: {train_accuracy * 100:.2f}%")

if train_accuracy > accuracy + 0.1:
    print("The model may be overfitting.")
elif accuracy > train_accuracy + 0.1:
    print("The model may be underfitting.")
else:
    print("The model seems well-fitted.")