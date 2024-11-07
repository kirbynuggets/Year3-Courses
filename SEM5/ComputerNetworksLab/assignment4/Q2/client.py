import socket

FLAG = 'F'
ESC = 'E'

def byte_unstuffing(stuffed_data):
    unstuffed_data = ''
    escape_next = False
    for char in stuffed_data:
        if escape_next:
            unstuffed_data += char
            escape_next = False
        elif char == ESC:
            escape_next = True
        elif char == FLAG:
            continue  # Skip the flag characters
        else:
            unstuffed_data += char
    return unstuffed_data

def client(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((host, port))
    print(f"Connected to server on {host}:{port}")
    return sock

def write(filename, data):
    with open(filename, 'a') as file:
        file.write(data)

if __name__ == '__main__':
    host = '127.0.0.1'
    port = 3000
    client_socket = client(host, port)

    i = 0

    while True:
        frame = client_socket.recv(1024).decode()
        if frame == "exit":
            break
        print("Received stuffed frame:", frame)

        unstuffed_frame = byte_unstuffing(frame)
        print("Unstuffed frame:", unstuffed_frame)

        i += 1
        acknowledgement = "ACK"
        if i != 3:
            client_socket.send(acknowledgement.encode())
            write("receive.txt", unstuffed_frame)
        print("Sent acknowledgement:", acknowledgement)
    print("Connection closed.")
