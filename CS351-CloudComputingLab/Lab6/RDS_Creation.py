import boto3

# Step 1: Set up AWS session with your credentials
session = boto3.Session(
    aws_access_key_id='AKIA2UC27Y66UVZGZLMO',
    aws_secret_access_key='k//njft6DRu1EM5qhxlV0AK8WRPyUMBAuidhTGx9',
    region_name='ap-south-1'
)

# Step 2: Create RDS client
rds_client = session.client('rds')

# Step 3: Define the parameters and create the RDS instance
response = rds_client.create_db_instance(
    DBInstanceIdentifier='rds-assignment6on',
    DBInstanceClass='db.t3.micro',
    Engine='mysql',
    MasterUsername='admin',
    MasterUserPassword='HelloWorld123',
    AllocatedStorage=20,  # in GB
    BackupRetentionPeriod=7,  # in days
    MultiAZ=False,  # Set to True if you need high availability
    PubliclyAccessible=True,  # Accessible over the internet
    DBName='feedbackDB6',
    StorageType='gp2',
    Tags=[{'Key': 'Name', 'Value': 'rds_assignment6on'}],
    VpcSecurityGroupIds=['sg-056c9b955612af158'],
)

print(f"Full response from RDS: {response}")
