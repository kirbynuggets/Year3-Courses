import numpy as np
import pandas as pd
from collections import Counter

# Dataset
data = pd.DataFrame({
    'Temperature': ['Hot', 'Hot', 'Mild', 'Cool', 'Cool'],
    'Weather': ['Sunny', 'Rainy', 'Cloudy', 'Sunny', 'Rainy'],
    'Play': ['No', 'Yes', 'Yes', 'Yes', 'No']
})

# Calculate entropy
def entropy(values):
    counts = Counter(values)
    probabilities = [count / len(values) for count in counts.values()]
    return -sum(p * np.log2(p) for p in probabilities if p > 0)

# Calculate information gain
def information_gain(data, feature, target):
    total_entropy = entropy(data[target])
    values, counts = np.unique(data[feature], return_counts=True)
    weighted_entropy = sum((counts[i] / sum(counts)) * entropy(data[data[feature] == values[i]][target])
                           for i in range(len(values)))
    return total_entropy - weighted_entropy

# Build the decision tree recursively
def build_tree(data, features, target):
    # Base case: if all target values are the same, return the target value
    if len(np.unique(data[target])) == 1:
        return np.unique(data[target])[0]

    # Base case: if no features are left, return the most common target value
    if len(features) == 0:
        return Counter(data[target]).most_common(1)[0][0]

    # Find the feature with the highest information gain
    gains = {feature: information_gain(data, feature, target) for feature in features}
    best_feature = max(gains, key=gains.get)

    # Create the subtree for the best feature
    tree = {best_feature: {}}
    remaining_features = [f for f in features if f != best_feature]

    for value in np.unique(data[best_feature]):
        subtree = build_tree(data[data[best_feature] == value], remaining_features, target)
        tree[best_feature][value] = subtree

    return tree

# Features and target
features = ['Temperature', 'Weather']
target = 'Play'

# Build the decision tree
decision_tree = build_tree(data, features, target)
print("Decision Tree:", decision_tree)
