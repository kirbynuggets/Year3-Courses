import numpy as np
import time

# Dataset: Total Spending, Number of Transactions, Average Purchase Value
data = np.array([
    [500, 10, 50],
    [1500, 15, 100],
    [200, 5, 40],
    [800, 20, 40],
    [300, 8, 37.5],
    [600, 12, 50],
    [1000, 10, 100],
    [450, 9, 50],
    [1200, 14, 85.71],
    [900, 7, 128.57]
])


def euclidean_distance(point1, point2):
    return np.sqrt(np.sum((point1 - point2) ** 2))


def total_sse(data, medoids, clusters):
    sse = 0
    for medoid_idx, cluster in clusters.items():
        medoid = medoids[medoid_idx]
        for point_idx in cluster:
            sse += euclidean_distance(data[point_idx], medoid) ** 2
    return sse


def k_medoids(data, k, max_iterations=100):
    m, n = data.shape
    medoid_indices = np.random.choice(m, k, replace=False)
    medoids = data[medoid_indices]

    # Initial Cluster Assignment for SSE
    initial_clusters = {}
    for idx, point in enumerate(data):
        distances = np.array([euclidean_distance(point, medoid) for medoid in medoids])
        nearest_medoid = np.argmin(distances)
        if nearest_medoid in initial_clusters:
            initial_clusters[nearest_medoid].append(idx)
        else:
            initial_clusters[nearest_medoid] = [idx]

    # Calculate Initial SSE
    initial_sse = total_sse(data, medoids, initial_clusters)
    print(f"Initial SSE: {initial_sse}")

    # Start measuring time
    start_time = time.time()

    for iteration in range(max_iterations):
        clusters = {}
        for idx, point in enumerate(data):
            distances = np.array([euclidean_distance(point, medoid) for medoid in medoids])
            nearest_medoid = np.argmin(distances)
            if nearest_medoid in clusters:
                clusters[nearest_medoid].append(idx)
            else:
                clusters[nearest_medoid] = [idx]

        current_cost = total_sse(data, medoids, clusters)
        best_medoids = np.copy(medoids)
        best_cost = current_cost

        for medoid_idx in range(k):
            for non_medoid_idx in range(m):
                if non_medoid_idx in medoid_indices:
                    continue
                new_medoids = np.copy(medoids)
                new_medoids[medoid_idx] = data[non_medoid_idx]

                new_clusters = {}
                for idx, point in enumerate(data):
                    distances = np.array([euclidean_distance(point, medoid) for medoid in new_medoids])
                    nearest_medoid = np.argmin(distances)
                    if nearest_medoid in new_clusters:
                        new_clusters[nearest_medoid].append(idx)
                    else:
                        new_clusters[nearest_medoid] = [idx]

                new_cost = total_sse(data, new_medoids, new_clusters)
                if new_cost < best_cost:
                    best_medoids = new_medoids
                    best_cost = new_cost

        if np.all(medoids == best_medoids):
            break
        medoids = best_medoids

    # Stop measuring time
    end_time = time.time()

    # Calculate Final SSE
    final_sse = total_sse(data, medoids, clusters)

    # Calculate effectiveness percentage
    effectiveness = ((initial_sse - final_sse) / initial_sse) * 100

    print(f"Final SSE: {final_sse}")
    print(f"Effectiveness: {effectiveness:.2f}%")
    print(f"Time Taken: {end_time - start_time:.4f} seconds")

    return medoids, clusters


# Number of clusters (k)
k = 3
medoids, clusters = k_medoids(data, k)

# Print the final results
print("Final Medoids:")
print(medoids)
for medoid_idx, cluster in clusters.items():
    print(f"Cluster {medoid_idx + 1}: {cluster}")
