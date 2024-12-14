import socket
import threading

class Hub:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server_socket.bind((self.host, self.port))
        self.server_socket.listen(5)
        self.client_sockets = []

    def broadcast_message(self, message):
        for client_socket in self.client_sockets:
            client_socket.send(message.encode())

    def handle_client(self, client_socket, client_id):
        while True:
            try:
                message = client_socket.recv(1024).decode()
                if not message:
                    break
                self.broadcast_message(message)
            except Exception as e:
                print(f"Error handling client {client_id}: {e}")
                break

    def start(self):
        print("Hub started. Waiting for clients...")
        for i in range(5):
            client_socket, address = self.server_socket.accept()
            self.client_sockets.append(client_socket)
            print(f"Client {i+1} connected.")
            client_thread = threading.Thread(target=self.handle_client, args=(client_socket, i+1))
            client_thread.start()

if __name__ == "__main__":
    hub = Hub('localhost', 12346)
    hub.start()