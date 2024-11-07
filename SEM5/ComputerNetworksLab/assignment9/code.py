import ipaddress

# Routing table as list of tuples in hexadecimal
routing_table = [
    ("C4.5E.02.00/23", "A"),  # 196.94.2.0
    ("C4.5E.04.00/22", "B"),  # 196.94.4.0
    ("C4.5E.C0.00/19", "C"),  # 196.94.192.0
    ("C4.5E.40.00/18", "D"),  # 196.94.64.0
    ("C4.4C.00.00/14", "E"),  # 196.76.0.0
    ("C0.00.00.00/2", "F"),   # 192.0.0.0
    ("80.00.00.00/1", "G"),   # 128.0.0.0
    ("00.00.00.00/0", "Default")  # Default route
]

# Helper function to convert hex IP to dotted decimal
def hex_to_dotted_decimal(hex_ip):
    try:
        hex_ip = hex_ip.split('.')  # Split the hex IP by '.'
        decimal_ip = ".".join(str(int(part, 16)) for part in hex_ip)  # Convert each part from hex to decimal
        return decimal_ip
    except ValueError:
        raise ValueError("Invalid hexadecimal IP address format")

# Function to perform IP forwarding based on CIDR and longest prefix match
def ip_forwarding(destination_ip):
    try:
        max_prefix = -1  # Initialize max prefix to -1
        next_hop = None  # Placeholder for next hop
        matched_entries = []  # List to store matched entries
        # Convert the hex IP to dotted decimal format
        dest_ip = hex_to_dotted_decimal(destination_ip)
        # Convert the destination IP to IPv4Address format
        dest_ip = ipaddress.IPv4Address(dest_ip)
        # Check each entry in the routing table
        for cidr, hop in routing_table:
            try:
                network = ipaddress.IPv4Network(hex_to_dotted_decimal(cidr.split('/')[0]) + '/' + cidr.split('/')[1])  # Convert the CIDR to a network object
                if dest_ip in network:  # Check if the destination IP is in this network
                    matched_entries.append((cidr, hop))  # Add to matched entries
                    # If the network has a longer prefix length, update the next hop
                    if network.prefixlen > max_prefix:
                        max_prefix = network.prefixlen
                        next_hop = hop
            except ValueError:
                print(f"Invalid routing table entry: {cidr}")
        # Print matched entries for better understanding
        print(f"Destination IP: {destination_ip} ({dest_ip})")
        print("Matched Entries:")
        for entry in matched_entries:
            print(f"  CIDR: {entry[0]}, Next Hop: {entry[1]}")
        if next_hop is not None:
            print(f"Selected Next Hop: {next_hop}\n")
        else:
            next_hop = "Default"
            print("No matching network found. Using default route.\n")
            print(f"Selected Next Hop: {next_hop}\n")
        return next_hop
    except ValueError as e:
        print(f"Error: {e}")
        return None

# Test the function with given IP addresses in hex format
ip_forwarding("C6.5E.D1.10")
ip_forwarding("192.168.02.00")
ip_forwarding("C4.4B.31.2E")
ip_forwarding("C4.5E.05.09")
ip_forwarding("C4.4D.31.2E")
ip_forwarding("C4.5E.03.87")
ip_forwarding("C4.5E.7F.12")
ip_forwarding("C4.5E.D1.02")
