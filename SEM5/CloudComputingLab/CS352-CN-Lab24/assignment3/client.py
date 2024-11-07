import socket
import sys
import threading

class Node:
    def __init__(self, host, port, node_id):
        self.host = host
        self.port = port
        self.node_id = node_id
        self.client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.client_socket.connect((self.host, self.port))

    def receive_message(self):
        while True:
            try:
                message = self.client_socket.recv(1024).decode()
                if not message:
                    break
                parts = message.split(":")
                if len(parts) == 3:
                    sender_id, recipient_id, text_message = parts
                    recipient_id = int(recipient_id)
                    sender_id = int(sender_id)
                    if recipient_id == self.node_id:
                        print(f"Node {self.node_id} received message from Node {sender_id}: {text_message}",flush=True)
                    else:
                        print(f"Node {self.node_id} discarded message from Node {sender_id} meant for Node {recipient_id}",flush=True)
                else:
                    print(f"Node {self.node_id} received a malformed message: {message}",flush=True)
            except Exception as e:
                print(f"Error receiving data from hub: {e}")
                break

    def send_message(self):
        while True:
            recipient_id = int(input(f"Enter the recipient ID (1-5) for Node {self.node_id}: "))
            input_message = input("Enter your message:\n")
            message = f"{self.node_id}:{recipient_id}:{input_message}"
            self.client_socket.send(message.encode())

    def start(self):
        receive_thread = threading.Thread(target=self.receive_message)
        receive_thread.start()
        self.send_message()

if __name__ == "__main__":
    node_id = int(sys.argv[1])
    node = Node('localhost', 12346, node_id)
    node.start()