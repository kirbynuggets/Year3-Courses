import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def euclidean_distance(p1, p2):
    p1 = np.array(p1)
    p2 = np.array(p2)
    return np.sqrt(np.sum((p1 - p2) ** 2))

def calculate_dbi(data, clusters, centroids):
    k = len(centroids)
    
    # Calculate intra-cluster distances (cluster dispersions)
    intra_distances = np.zeros(k)
    for i, (cluster_id, points) in enumerate(clusters.items()):
        if len(points) > 0:
            centroid = centroids[i]
            intra_distances[i] = np.mean([euclidean_distance(point, centroid) for point in points])

    inter_distances = np.zeros((k, k))
    for i in range(k):
        for j in range(i + 1, k):
            inter_distances[i, j] = euclidean_distance(centroids[i], centroids[j])
            inter_distances[j, i] = inter_distances[i, j]

    dbi = 0
    for i in range(k):
        max_ratio = 0
        for j in range(k):
            if i != j:
                ratio = (intra_distances[i] + intra_distances[j]) / inter_distances[i, j]
                max_ratio = max(max_ratio, ratio)
        dbi += max_ratio

    return dbi / k

def kmeans(data, k, max_iter=1000, tol=1e-4, stop_criterion='max_iter', dbi_threshold=0.5):
    centroids = data[np.random.choice(data.shape[0], k, replace=False)]
    
    for i in range(max_iter):
        clusters = {j: [] for j in range(k)}
        
        for point in data:
            distances = [euclidean_distance(point, centroid) for centroid in centroids]
            cluster = distances.index(min(distances))
            clusters[cluster].append(point)
        
        new_centroids = [np.mean(clusters[cluster], axis=0) for cluster in clusters]
        
        if stop_criterion == 'centroid_unchanged':
            if all(np.all(np.abs(new_centroids[j] - centroids[j]) < tol) for j in range(k)):
                print(f"Stopping early at iteration {i+1} due to unchanged centroids.")
                return clusters, new_centroids, i+1
        
        elif stop_criterion == 'quality':
            dbi = calculate_dbi(data, clusters, new_centroids)
            print("Found DBI:", dbi)
            if dbi < dbi_threshold:
                print(f"Stopping early at iteration {i+1} due to DBI threshold.")
                return clusters, new_centroids, i+1

        centroids = new_centroids

    print(f"Reached maximum iterations: {max_iter}")
    return clusters, centroids, max_iter

def plot_clusters(ax, clusters, centroids, title):
    colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k']
    for cluster_id, points in clusters.items():
        points = np.array(points)
        ax.scatter(points[:, 0], points[:, 1], c=colors[cluster_id % len(colors)], marker='x', label=f'Cluster {cluster_id + 1}')
        ax.scatter(centroids[cluster_id][0], centroids[cluster_id][1], c=colors[cluster_id % len(colors)], marker='o', s=100, edgecolors='k', linewidths=2)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_title(title)
    ax.legend()

def main():
    data = pd.read_csv("points.csv").values

    fig, axs = plt.subplots(1, 3, figsize=(18, 6))

    clusters, centroids, iters = kmeans(data, 3, max_iter=100, stop_criterion='max_iter')
    plot_clusters(axs[0], clusters, centroids, f"Max Iterations\n({iters} iterations)")

    clusters, centroids, iters = kmeans(data, 3, max_iter=100, stop_criterion='centroid_unchanged')
    plot_clusters(axs[1], clusters, centroids, f"Centroid Unchanged\n({iters} iterations)")

    clusters, centroids, iters = kmeans(data, 3, max_iter=100, stop_criterion='quality', dbi_threshold=0.5)
    plot_clusters(axs[2], clusters, centroids, f"Highest Quality\n({iters} iterations)")

    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()