import socket


def client(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((host, port))
    print(f"Connected to server on {host}:{port}")
    return sock


def write(filename, data):
    with open(filename, 'a') as file:
        file.write(data)


if __name__ == "__main__":
    port = 3000
    host = '127.0.0.1'
    client_socket = client(host, port)
    skip_ack_for_frame = 2

    i = 0
    while True:
        data = client_socket.recv(1024).decode()
        if data == "END":
            break
        print(f"Received frame {i}: {data}")
        write('received_data.txt', data)

        if i != skip_ack_for_frame:
            ack = "Acknowledged"
            client_socket.send(ack.encode())
            print(f"Sent ack: {ack}")
        else:
            print(f"Deliberately skipping ack for frame {i}")

        i += 1

    print("Data received successfully")
    client_socket.close()
