import boto3

# Create EC2 resource and client
ec2 = boto3.resource('ec2')
client = boto3.client('ec2')

# Retrieve all running instances
instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

# Create a list of instance IDs
instance_ids = [instance.id for instance in instances]

# Check if there are any instances to stop
if instance_ids:
    # Terminate the instances
    client.terminate_instances(InstanceIds=instance_ids)
    print("Terminating instances:", instance_ids)
else:
    print("No running instances to terminate.")
