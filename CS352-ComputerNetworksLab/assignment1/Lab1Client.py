import socket
import sys

# Client configuration
server_ip = sys.argv[1]
server_port = int(sys.argv[2])

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect((server_ip, server_port))

try:
    while True:
        message = input("Please enter a string: ")
        client_socket.sendall(message.encode())

        response = client_socket.recv(1024)
        print(f'Received response: {response.decode()}')

finally:
    client_socket.close()
