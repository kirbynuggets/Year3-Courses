# Launch two t2.micro Ubuntu instances
import boto3

ec2 = boto3.resource('ec2')

ubuntu_instances = ec2.create_instances(
    ImageId='ami-0522ab6e1ddcc7055',  # Ubuntu AMI ID
    MinCount=2,
    MaxCount=2,
    InstanceType='t2.micro',
    KeyName='assignment3',
)

for instance in ubuntu_instances:
    print("Ubuntu instance launched:", instance.id)


