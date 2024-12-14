import boto3

ec2 = boto3.resource('ec2')

# Launch a t2.micro Amazon Linux instance
instance = ec2.create_instances(
    ImageId='ami-0e53db6fd757e38c7',
    MinCount=1,
    MaxCount=1,
    InstanceType='t2.micro',
    KeyName='assignment3',
)

print("Amazon Linux instance launched:", instance[0].id)
