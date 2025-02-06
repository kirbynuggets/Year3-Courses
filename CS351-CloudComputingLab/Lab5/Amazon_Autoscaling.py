import boto3
import time

# Initialize clients
ec2_client = boto3.client('ec2', region_name='ap-south-1')
autoscaling_client = boto3.client('autoscaling', region_name='ap-south-1')
cloudwatch_client = boto3.client('cloudwatch', region_name='ap-south-1')

# Load the startup script
with open('startup.sh', 'r') as file:
    user_data_script = file.read()

# Define Launch Configuration with UserData (startup script)
autoscaling_client.create_launch_configuration(
    LaunchConfigurationName='LCAssignment5on5',
    ImageId='ami-0522ab6e1ddcc7055',
    InstanceType='t2.micro',
    KeyName='assignment4',
    SecurityGroups=['sg-0d76ec2ae2107efd7'],
    UserData=user_data_script
)

# Create Auto Scaling Group
autoscaling_client.create_auto_scaling_group(
    AutoScalingGroupName="ASGassignment5on",
    LaunchConfigurationName='LCAssignment5on5',
    MinSize=1,
    MaxSize=5,
    DesiredCapacity=1,
    AvailabilityZones=['ap-south-1a', 'ap-south-1b', 'ap-south-1c'],  # Correct availability zones
)

# Scale Up Policy
scale_up_policy = autoscaling_client.put_scaling_policy(
    AutoScalingGroupName='ASGassignment5on',
    PolicyName='ScaleUp',
    AdjustmentType='ChangeInCapacity',
    ScalingAdjustment=1
)

# Scale Down Policy
scale_down_policy = autoscaling_client.put_scaling_policy(
    AutoScalingGroupName='ASGassignment5on',
    PolicyName='ScaleDown',
    AdjustmentType='ChangeInCapacity',
    ScalingAdjustment=-1
)

# Create CloudWatch Alarms for scaling
cloudwatch_client.put_metric_alarm(
    AlarmName='ScaleUpAlarm',
    MetricName='CPUUtilization',
    Namespace='AWS/EC2',
    Statistic='Average',
    Period=60,
    Threshold=70.0,  # Scale up when CPU utilization is above 70%
    ComparisonOperator='GreaterThanThreshold',
    EvaluationPeriods=2,
    AlarmActions=[scale_up_policy['PolicyARN']],
    Dimensions=[{'Name': 'AutoScalingGroupName', 'Value': 'ASGassignment5on'}]
)
cloudwatch_client.put_metric_alarm(
    AlarmName='ScaleDownAlarm',
    MetricName='CPUUtilization',
    Namespace='AWS/EC2',
    Statistic='Average',
    Period=60,
    Threshold=30.0,  # Scale down when CPU utilization is below 30%
    ComparisonOperator='LessThanThreshold',
    EvaluationPeriods=2,
    AlarmActions=[scale_down_policy['PolicyARN']],
    Dimensions=[{'Name': 'AutoScalingGroupName', 'Value': 'ASGassignment5on'}]
)

print("Auto Scaling Group, Policies, and Alarms created successfully!")

def get_ec2_instance_public_dns(asg_name):
    # Wait for a few seconds to give the instance time to launch
    print("Waiting for instance to launch...")
    time.sleep(60)  # Wait for 60 seconds (adjust as needed)

    # Get list of all instances
    response = ec2_client.describe_instances()

    # Loop through reservations and instances
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            # Check if the instance belongs to the correct Auto Scaling Group
            for tag in instance.get('Tags', []):
                if tag['Key'] == 'aws:autoscaling:groupName' and tag['Value'] == asg_name:
                    # Ensure the instance is in running state
                    if instance['State']['Name'] == 'running':
                        public_dns = instance.get('PublicDnsName', 'N/A')
                        print(f"Instance ID: {instance['InstanceId']}, Public DNS: {public_dns}")
                        return public_dns
    return None

# Name of your Auto Scaling Group
asg_name = 'ASGassignment5on'

# Get public DNS of the instance
public_dns = get_ec2_instance_public_dns(asg_name)
if public_dns:
    print(f"Access your static website at: http://{public_dns}")
else:
    print("No running instance found for the Auto Scaling Group.")
