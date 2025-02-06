import boto3

# Create EC2 resource and client
ec2 = boto3.resource('ec2')
client = boto3.client('ec2')

# Retrieve all running instances
instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

# Check the health of all running instances
for instance in instances:
    status = client.describe_instance_status(InstanceIds=[instance.id])
    if status['InstanceStatuses']:
        for stat in status['InstanceStatuses']:
            print(f"Instance {stat['InstanceId']} - Status: {stat['InstanceState']['Name']} - Health: {stat['InstanceStatus']['Status']}")
    else:
        print(f"Instance {instance.id} does not have a status check report yet.")
