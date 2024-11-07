import socket
import os
import multiprocessing

# Server details
host = '127.0.0.1'
port = 5555

# Function to handle client communication
def handle_client(connection, client_address):
    print("Connection from", client_address)
    try:
        while True:
            data = connection.recv(1024)
            if not data:
                break
            print(f'Received data from {client_address}:', data.decode())

            # Send the reversed string back to the client
            response = data.decode()[::-1]
            connection.sendall(response.encode())
    finally:
        connection.close()

# Creating a TCP/IP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_socket.bind((host, port))


server_socket.listen(5)
print("Server2 is listening for incoming connections...")

try:
    while True:
        # Accept a connection
        connection, client_address = server_socket.accept()

        # Create a new process to handle the client
        client_process = multiprocessing.Process(target=handle_client, args=(connection, client_address))
        client_process.start()

finally:
    server_socket.close()
