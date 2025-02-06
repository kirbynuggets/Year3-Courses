import boto3
import time

ec2 = boto3.client('ec2', region_name='ap-south-1')

def launch_instance():
    user_data = #!/bin/bash
    apt update -y
    apt install -y apache2
    systemctl start apache2
    systemctl enable apache2
    wget https://assignment3buckaws.s3.ap-south-1.amazonaws.com/index.html
    sudo mv index.html /var/www/html/
    wget https://assignment3buckaws.s3.ap-south-1.amazonaws.com/random.html
    sudo mv random.html /var/www/html/
    

    instance = ec2.run_instances(
        ImageId='ami-0e53db6fd757e38c7',
        InstanceType='t2.micro',
        MinCount=1,
        MaxCount=1,
        SecurityGroupIds=['sg-0d76ec2ae2107efd7'],
        UserData=user_data,
        KeyName='assignment3',
    )

    instance_id = instance['Instances'][0]['InstanceId']
    print(f'Instance {instance_id} launched. Waiting for it to enter "running" state...')

    ec2_resource = boto3.resource('ec2', region_name='ap-south-1')
    instance = ec2_resource.Instance(instance_id)

    instance.wait_until_running()
    instance.load()
    time.sleep(10)

    print(f'Instance is running. Public DNS: {instance.public_dns_name}')
    return instance.public_dns_name

if __name__ == '__main__':
    dns = launch_instance()
    print(f'Website available at http://{dns}')
