import socket


def server():
    # Server settings
    host = '127.0.0.1'
    port = 12345

    # Create and bind the server socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.bind((host, port))
        server_socket.listen(5)
        print("Server started and listening for connections...")

        # Store client connections
        clients = {}

        while True:
            # Accept client connections
            client_socket, addr = server_socket.accept()
            print(f"Connected to node {addr}")
            clients[addr] = client_socket

            # Handle client messages
            message = client_socket.recv(1024).decode()
            print(f"Received message: {message} from node {addr}")

            # Broadcast message to other nodes
            for client_addr, client in clients.items():
                if client_addr != addr:
                    client.sendall(message.encode())
                    print(f"Broadcasting message to node {client_addr}")

            # Close connection after broadcasting
            client_socket.close()
            del clients[addr]
            print(f"Connection closed for node {addr}")


if __name__ == "__main__":
    server()
