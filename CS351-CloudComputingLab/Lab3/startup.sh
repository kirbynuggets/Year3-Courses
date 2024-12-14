#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2
systemctl enable apache2
wget https://assignment3buck1.s3.eu-north-1.amazonaws.com/index.html
sudo mv index.html /var/www/html/
wget https://assignment3buck1.s3.eu-north-1.amazonaws.com/random.html
sudo mv random.html /var/www/html/
