import paramiko

# SSH into the Amazon Linux instance
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

# Connect to your Amazon Linux instance (use public IP and your key file)
ssh.connect('13.201.167.49', username='ec2-user', key_filename='assignment4.pem')

# Install and start Apache HTTP server
commands = [
    'sudo yum update -y',
    'sudo yum install -y httpd',
    'sudo systemctl start httpd',
    'sudo systemctl enable httpd'
]

for command in commands:
    stdin, stdout, stderr = ssh.exec_command(command)
    print(stdout.read().decode(), stderr.read().decode())

print("HTTP server is running on Amazon Linux instance")
ssh.close()
