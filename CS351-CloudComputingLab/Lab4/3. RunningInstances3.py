#List all running Instances
import boto3

ec2 = boto3.resource('ec2')

instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

print("Running instances:")
for instance in instances:
    print(instance.id, instance.instance_type, instance.state['Name'], instance.public_ip_address)
