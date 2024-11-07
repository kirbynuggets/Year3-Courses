import math

MAX_ROUTES = 128
MAX_TIME_ROUTE = 120
INFINITY = math.inf

network_graph = {
    'A': ['B', 'C', 'E', 'F'],
    'B': ['A', 'C'],
    'C': ['B', 'D', 'A'],
    'D': ['C', 'G'],
    'E': ['A'],
    'F': ['A', 'G'],
    'G': ['D', 'F']
}

distance_vectors = {node: {dest: INFINITY for dest in network_graph} for node in network_graph}
for node in network_graph:
    distance_vectors[node][node] = 0

for neighbor in network_graph['A']:
    distance_vectors['A'][neighbor] = 1


def print_distance_vector(node):
    print(f"Distance vector for {node}: {distance_vectors[node]}")


def update_distance_vector(node):
    updated = False
    for neighbor in network_graph[node]:
        for dest in distance_vectors[neighbor]:
            new_cost = distance_vectors[neighbor][dest] + 1
            if new_cost < distance_vectors[node][dest]:
                distance_vectors[node][dest] = new_cost
                updated = True
    return updated


def simulate_round():
    """Simulate one round of distance vector updates for all nodes."""
    updates = {}
    for node in network_graph:
        updates[node] = update_distance_vector(node)
    return any(updates.values())


print("Initial distance vector for A:")
print_distance_vector('A')

round_count = 1
while True:
    print(f"\nRound {round_count}:")
    print("Vectors received at A from its neighbors:")
    for neighbor in network_graph['A']:
        print(f"From {neighbor}: {distance_vectors[neighbor]}")
    any_updates = simulate_round()
    print("Updated distance vector for A:")
    print_distance_vector('A')

    if not any_updates:
        print("\nDistance vectors have converged. Final distance vector for A:")
        print_distance_vector('A')
        break

    round_count += 1
