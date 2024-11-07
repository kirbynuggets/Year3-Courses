import socket

def frame(data):
    return [data[i:i+5] for i in range(0, len(data), 5)]

def read(filename):
    with open(filename, 'r') as file:
        return file.read()

def server(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((host, port))
    sock.listen(1)
    print(f"Server is listening on {host}:{port}")
    return sock

if __name__ == "__main__":
    host = '127.0.0.1'
    port = 3000
    server_socket = server(host, port)
    client_socket, client_address = server_socket.accept()

    data = read('data.txt')
    print("Sending data to client:", data)
    frame_data = frame(data)

    for i, frame in enumerate(frame_data):
        while True:
            client_socket.send(frame.encode())
            print(f"Sent frame {i}: {frame}")
            client_socket.settimeout(2.0)
            try:
                ack = client_socket.recv(1024).decode()
                print(f"Received ack: {ack}")
                if ack == "Acknowledged":
                    break
            except socket.timeout:
                print(f"No ACK received for frame {i}, resending...")

    client_socket.send("END".encode())
    print("Finished sending data")
    client_socket.close()
    server_socket.close()
