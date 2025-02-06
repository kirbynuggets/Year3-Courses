import boto3
import json

# Initialize the IAM client
iam = boto3.client('iam')

role_name = 'Assignment7-NewRole'

# Create the Role
role_policy_document = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}

try:
    role = iam.create_role(
        RoleName=role_name,
        AssumeRolePolicyDocument=json.dumps(role_policy_document),
        Description='Role for Elastic Beanstalk Web Tier'
    )
    print(f"Created Role: {role['Role']['RoleName']}")
except iam.exceptions.EntityAlreadyExistsException:
    print(f"Role {role_name} already exists!")

# Attach the AWSElasticBeanstalkWebTier Policy
response = iam.attach_role_policy(
    RoleName=role_name,
    PolicyArn="arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
)

print(f"Attached Policy to {role_name}")