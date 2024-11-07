import socket
import threading

FLAG = 'F'
ESC = 'E'

def byte_stuffing(data):
    stuffed_data = FLAG
    for char in data:
        if char == FLAG or char == ESC:
            stuffed_data += ESC
        stuffed_data += char
    stuffed_data += FLAG
    return stuffed_data

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

def resend_frames(frame, client_socket, id):
    print("")
    print("Acknowledgement not received for frame:", frame)
    print(f"Resending frame with id: {id} content: {frame}")
    client_socket.send(frame.encode())
    print("Frame sent")
    print("")

if __name__ == '__main__':
    host = '127.0.0.1'
    port = 3000
    server_socket = server(host, port)
    client_socket, client_address = server_socket.accept()
    data = read("send.txt")
    stuffed_data = byte_stuffing(data)
    frame_data = frame(stuffed_data)
    exit_msg = "exit"
    index = 0
    for frame in frame_data:
        client_socket.send(frame.encode())
        print("Sent frame:", frame)
        timer = threading.Timer(2, resend_frames, args=(frame, client_socket, index))
        timer.start()
        acknowledgement = client_socket.recv(1024).decode()
        if acknowledgement == "ACK":
            timer.cancel()
            print("Received acknowledgement:", acknowledgement)
        index += 1

    client_socket.send(exit_msg.encode())

#Byte Stuffing