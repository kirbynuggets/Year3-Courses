import boto3
import zipfile
import os
import json

# Constants
APPLICATION_NAME = "MyApp"
APPLICATION_VERSION = "v7-7"
ENVIRONMENT_NAME = "assignment7env"
S3_BUCKET_NAME = "myapp-assignment7"
ZIP_FILE_NAME = "myapp.zip"
INSTANCE_PROFILE_NAME = "Assignment7-InstanceProfile"
ROLE_NAME = "Assignment7-NewRole"
REGION = "ap-south-1"  # Replace with your desired region

# Initialize clients
s3_client = boto3.client('s3', region_name=REGION)
eb_client = boto3.client('elasticbeanstalk', region_name=REGION)
iam_client = boto3.client('iam', region_name=REGION)

def create_zip_file():
    with zipfile.ZipFile(ZIP_FILE_NAME, 'w') as zipf:
        for root, _, files in os.walk('.'):
            for file in files:
                if file.endswith(".py") or file.endswith(".html") or file == "requirements.txt":
                    zipf.write(os.path.join(root, file), os.path.relpath(os.path.join(root, file), '.'))
    print(f"Created zip file: {ZIP_FILE_NAME}")

def create_s3_bucket():
    try:
        s3_client.create_bucket(Bucket=S3_BUCKET_NAME, CreateBucketConfiguration={'LocationConstraint': REGION})
        print(f"Created S3 bucket: {S3_BUCKET_NAME}")
    except s3_client.exceptions.BucketAlreadyOwnedByYou:
        print(f"S3 bucket '{S3_BUCKET_NAME}' already exists.")

def upload_zip_file_to_s3():
    s3_client.upload_file(ZIP_FILE_NAME, S3_BUCKET_NAME, ZIP_FILE_NAME)
    print(f"Uploaded {ZIP_FILE_NAME} to S3 bucket {S3_BUCKET_NAME}.")

def create_iam_role_and_instance_profile():
    try:
        role_policy_document = {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {"Service": "ec2.amazonaws.com"},
                    "Action": "sts:AssumeRole"
                }
            ]
        }
        try:
            iam_client.get_role(RoleName=ROLE_NAME)
            print(f"Role '{ROLE_NAME}' already exists.")
        except iam_client.exceptions.NoSuchEntityException:
            iam_client.create_role(
                RoleName=ROLE_NAME,
                AssumeRolePolicyDocument=json.dumps(role_policy_document),
                Description='Role for Elastic Beanstalk Web Tier'
            )
            print(f"Created Role: {ROLE_NAME}")

        iam_client.attach_role_policy(RoleName=ROLE_NAME, PolicyArn="arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier")
        iam_client.attach_role_policy(RoleName=ROLE_NAME, PolicyArn="arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess")
        print(f"Attached necessary policies to role '{ROLE_NAME}'.")

        try:
            iam_client.get_instance_profile(InstanceProfileName=INSTANCE_PROFILE_NAME)
            print(f"Instance profile '{INSTANCE_PROFILE_NAME}' already exists.")
        except iam_client.exceptions.NoSuchEntityException:
            iam_client.create_instance_profile(InstanceProfileName=INSTANCE_PROFILE_NAME)
            iam_client.add_role_to_instance_profile(InstanceProfileName=INSTANCE_PROFILE_NAME, RoleName=ROLE_NAME)
            print(f"Instance profile '{INSTANCE_PROFILE_NAME}' created and role attached.")

    except Exception as e:
        print(f"Error creating IAM role or instance profile: {e}")

def create_application():
    try:
        eb_client.describe_applications(ApplicationNames=[APPLICATION_NAME])
        print(f"Application '{APPLICATION_NAME}' already exists.")
    except eb_client.exceptions.ClientError:
        eb_client.create_application(ApplicationName=APPLICATION_NAME)
        print(f"Application '{APPLICATION_NAME}' created successfully.")

def create_application_version():
    try:
        response = eb_client.describe_application_versions(
            ApplicationName=APPLICATION_NAME,
            VersionLabels=[APPLICATION_VERSION]
        )
        if response['ApplicationVersions']:
            print(f"Application version '{APPLICATION_VERSION}' already exists.")
        else:
            eb_client.create_application_version(
                ApplicationName=APPLICATION_NAME,
                VersionLabel=APPLICATION_VERSION,
                SourceBundle={
                    'S3Bucket': S3_BUCKET_NAME,
                    'S3Key': ZIP_FILE_NAME
                }
            )
            print(f"Application version '{APPLICATION_VERSION}' created successfully.")
    except eb_client.exceptions.ClientError as e:
        print(f"An error occurred: {e}")

def create_environment():
    try:
        response = eb_client.describe_environments(
            ApplicationName=APPLICATION_NAME,
            EnvironmentNames=[ENVIRONMENT_NAME],
            IncludeDeleted=False
        )
        if response['Environments']:
            print(f"Environment '{ENVIRONMENT_NAME}' already exists.")
        else:
            eb_client.create_environment(
                ApplicationName=APPLICATION_NAME,
                EnvironmentName=ENVIRONMENT_NAME,
                VersionLabel=APPLICATION_VERSION,
                SolutionStackName="64bit Amazon Linux 2023 v4.2.0 running Python 3.9",
                OptionSettings=[
                    {
                        'Namespace': 'aws:autoscaling:launchconfiguration',
                        'OptionName': 'IamInstanceProfile',
                        'Value': INSTANCE_PROFILE_NAME
                    },
                    {
                        'Namespace': 'aws:elasticbeanstalk:environment:proxy',
                        'OptionName': 'ProxyServer',
                        'Value': 'nginx'
                    },
                    {
                        'Namespace': 'aws:elasticbeanstalk:application:environment',
                        'OptionName': 'PORT',
                        'Value': '5000'  # Ensure this matches the port your application is using
                    },
                    {
                        'Namespace': 'aws:elb:listener',
                        'OptionName': 'ListenerEnabled',
                        'Value': 'true'
                    }
                ]
            )
            print(f"Environment '{ENVIRONMENT_NAME}' created successfully.")
    except eb_client.exceptions.ClientError as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    create_zip_file()
    create_s3_bucket()
    upload_zip_file_to_s3()
    create_iam_role_and_instance_profile()
    create_application()
    create_application_version()
    create_environment()