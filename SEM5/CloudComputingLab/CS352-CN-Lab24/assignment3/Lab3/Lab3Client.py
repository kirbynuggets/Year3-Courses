import socket


def client(node_id, message, destination):
    # Client settings
    host = '127.0.0.1'
    port = 12345

    # Create and connect the client socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
        client_socket.connect((host, port))

        # Send the message with destination address
        full_message = f"Node {node_id} to Node {destination}: {message}"
        client_socket.sendall(full_message.encode())
        print(f"Node {node_id}: Sent message - {full_message}")

        # Receive and process messages
        try:
            received_message = client_socket.recv(1024).decode()
            print(f"Node {node_id}: Received message - {received_message}")

            # Check if the message is intended for this node
            if f"Node {destination}" in received_message:
                print(f"Node {node_id}: Message accepted")
            else:
                print(f"Node {node_id}: Message discarded")

        except socket.error as e:
            print(f"Node {node_id}: Error receiving message - {e}")


if __name__ == "__main__":
    node_id = 2  # Example: This is Node 2
    message = "Hello from Node 2"
    destination = 3  # Example: The message is intended for Node 3
    client(node_id, message, destination)
