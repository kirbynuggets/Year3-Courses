import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import adjusted_rand_score
from minisom import MiniSom  # SOM library

# Load the Iris dataset
iris = datasets.load_iris()
data = iris.data
labels = iris.target

# Normalize the data
scaler = MinMaxScaler()
data = scaler.fit_transform(data)

# ----- Implementing 1-D SOM from scratch -----
class SelfOrganizingMap:
    def __init__(self, input_dim, map_dim, learning_rate=0.5, radius=1.0, epochs=100):
        self.input_dim = input_dim
        self.map_dim = map_dim
        self.learning_rate = learning_rate
        self.radius = radius
        self.epochs = epochs

        # Initialize weights randomly
        self.weights = np.random.rand(self.map_dim, self.input_dim)

    def _find_bmu(self, sample):
        """Find the Best Matching Unit (BMU) for a given sample."""
        distances = np.linalg.norm(self.weights - sample, axis=1)
        return np.argmin(distances)

    def _update_weights(self, sample, bmu_idx, epoch):
        """Update the weights of the SOM."""
        for i in range(self.map_dim):
            distance_to_bmu = np.abs(i - bmu_idx)
            if distance_to_bmu <= self.radius:
                influence = np.exp(-distance_to_bmu**2 / (2 * (self.radius**2)))
                learning_rate = self.learning_rate * (1 - epoch / self.epochs)
                self.weights[i] += influence * learning_rate * (sample - self.weights[i])

    def train(self, data):
        """Train the SOM."""
        for epoch in range(self.epochs):
            for sample in data:
                bmu_idx = self._find_bmu(sample)
                self._update_weights(sample, bmu_idx, epoch)

    def predict(self, data):
        """Predict cluster indices for data."""
        predictions = []
        for sample in data:
            bmu_idx = self._find_bmu(sample)
            predictions.append(bmu_idx)
        return np.array(predictions)

# Train the custom SOM
som_custom = SelfOrganizingMap(input_dim=4, map_dim=3, learning_rate=0.5, radius=1.0, epochs=200)
som_custom.train(data)
custom_predictions = som_custom.predict(data)

# ----- In-built SOM library (MiniSom) -----
som_library = MiniSom(x=3, y=1, input_len=4, sigma=1.0, learning_rate=0.5)
som_library.random_weights_init(data)
som_library.train_random(data, 100)

library_predictions = [som_library.winner(sample)[0] for sample in data]

# ----- Performance Comparison -----
# Map SOM predictions to the ground truth using adjusted_rand_score
custom_score = adjusted_rand_score(labels, custom_predictions)
library_score = adjusted_rand_score(labels, library_predictions)

print(f"Custom SOM Adjusted Rand Index: {custom_score}")
print(f"In-built SOM (MiniSom) Adjusted Rand Index: {library_score}")

# ----- Visualization -----
plt.figure(figsize=(10, 5))

# Custom SOM Results
plt.subplot(1, 2, 1)
plt.scatter(data[:, 0], data[:, 1], c=custom_predictions, cmap='viridis', s=50)
plt.title("Custom SOM Clusters")
plt.xlabel("Feature 1")
plt.ylabel("Feature 2")

# Library SOM Results
plt.subplot(1, 2, 2)
plt.scatter(data[:, 0], data[:, 1], c=library_predictions, cmap='viridis', s=50)
plt.title("Library SOM Clusters")
plt.xlabel("Feature 1")
plt.ylabel("Feature 2")

plt.tight_layout()
plt.show()
