import boto3

# Set up AWS session with your credentials
session = boto3.Session(
    aws_access_key_id='AKIA2UC27Y66UVZGZLMO',
    aws_secret_access_key='k//njft6DRu1EM5qhxlV0AK8WRPyUMBAuidhTGx9',
    region_name='ap-south-1'
)

# Create RDS client
rds_client = session.client('rds')

# Get the instance details
response = rds_client.describe_db_instances(DBInstanceIdentifier='rds-assignment6on')
db_instances = response['DBInstances']

for db_instance in db_instances:
    endpoint = db_instance['Endpoint']['Address']
    print(f"Endpoint: {endpoint}")
