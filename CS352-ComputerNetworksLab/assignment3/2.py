HEADER_SIZE = 64

def add_header(message,header):
    new_message = header.ljust(HEADER_SIZE) + message
    return new_message

def application_layer(message,message_size):
    message = add_header(message,"Application Layer Header")
    print(f"The message after application layer is ({message}) \nSize is {len(message)}\n\n")
    presentation_layer(message,len(message))
    
def presentation_layer(message,message_size):
    message = add_header(message,"Presentation Layer Header")
    print(f"The message after presentation layer is ({message}) \nSize is {len(message)}\n\n")
    session_layer(message,len(message))
    
def session_layer(message,message_size):
    message = add_header(message,"Session Layer Header")
    print(f"The message after session layer is ({message}) \nSize is {len(message)}\n\n")
    transport_layer(message,len(message))
    
def transport_layer(message,message_size):
    message = add_header(message,"Transport Layer Header")
    print(f"The message after transport layer is ({message}) \nSize is {len(message)}\n\n")
    network_layer(message,len(message))

def network_layer(message,message_size):
    message = add_header(message,"Network Layer Header")
    print(f"The message after network layer is ({message}) \nSize is {len(message)}\n\n")
    data_link_layer(message,len(message))

def data_link_layer(message,message_size):
    message = add_header(message,"Data Link Layer Header")
    message += " Data Link Layer Trailer"
    print(f"The message after data link layer is ({message}) \nSize is {len(message)}\n\n")
    physical_layer(message,len(message))
    
def physical_layer(message,message_size):
    message = add_header(message,"Physical Layer Header")
    print(f"The message after physical layer is ({message}) \nSize is {len(message)}\n\n")
    

message = input("Enter the application message: ")
message_size = len(message)
print(f"The initial message is ({message}) \nSize is {len(message)}\n\n")
application_layer(message,message_size)