import socket

# Server details
host = '127.0.0.1'  # localhost
port = 5555

#TCP/IP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print(server_socket)

server_socket.bind((host, port))

server_socket.listen(1)
print("Server1 is listening for incoming connections...")

# Accept connection
connection, client_address = server_socket.accept()
print("Connection from", client_address)

try:
    while True:
        data = connection.recv(1024)
        if not data:
            break
        print('Received data:', data.decode())

        # Send the reversed string back to the client
        response = data.decode()[::-1]
        connection.sendall(response.encode())

finally:
    connection.close()
    server_socket.close()
