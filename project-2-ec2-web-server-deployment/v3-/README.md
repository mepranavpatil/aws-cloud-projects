🖥️ Project Report — Web Server Deployment on AWS EC2 using Nginx
📌 1. Introduction

This project demonstrates the deployment of a static website on a cloud-based virtual server using Amazon EC2 and Nginx. The objective is to understand how real-world web hosting works by manually configuring infrastructure, networking, and server components.

Unlike managed services, this project provides full control over the server environment, enabling deeper learning of system administration and DevOps fundamentals.

🎯 2. Objectives

To launch and configure an EC2 instance

To establish secure SSH access using key-based authentication

To install and configure Nginx as a web server

To deploy a static website

To implement security using AWS Security Groups and UFW firewall

To troubleshoot real-world deployment issues

🏗️ 3. System Architecture

The architecture consists of multiple layers ensuring secure and efficient delivery of web content:

User sends an HTTP request via browser

Request passes through AWS Security Group (cloud firewall)

Then through UFW (OS-level firewall)

Finally reaches Nginx running on EC2

Nginx serves the website from /var/www/html/

🧰 4. Tools and Technologies Used
Component	Description
AWS EC2	Cloud virtual machine
Ubuntu 22.04 LTS	Operating system
Nginx	Web server
SSH	Remote server access
UFW	OS-level firewall
Security Group	AWS-level firewall
⚙️ 5. EC2 Configuration Details
Parameter	Value
Instance Name	devops-project-ec2
Instance Type	t2.micro
Region	ap-south-1
Storage	8 GB
OS	Ubuntu 22.04 LTS
Access Method	SSH using .pem key
🔒 6. Security Implementation
6.1 AWS Security Group

Port 22 (SSH): Allowed only from personal IP

Port 80 (HTTP): Allowed from anywhere

6.2 UFW Firewall (Instance Level)

SSH access allowed

HTTP traffic allowed

All other traffic denied by default

This ensures defense in depth, combining cloud-level and OS-level protection.

🚀 7. Implementation Steps
Step 1: Launch EC2 Instance

Selected Ubuntu 22.04 AMI

Configured security group for SSH and HTTP

Generated key pair for authentication

Step 2: Connect via SSH
ssh -i devops-ec2-key.pem ubuntu@<public-ip>
Step 3: Install Nginx
sudo apt update
sudo apt install nginx -y
Step 4: Start and Enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx
Step 5: Deploy Website

Navigated to /var/www/html/

Removed default Nginx page

Created a new index.html file

Step 6: Configure Firewall
sudo ufw allow ssh
sudo ufw allow http
sudo ufw enable
Step 7: Access Website

Opened in browser:

http://<public-ip>

Website successfully loaded.

🐛 8. Challenges Faced and Debugging
Issue 1: Nginx Service Failed to Start

Cause:

Incorrect configuration file syntax

Solution:

sudo nginx -t

Identified syntax error

Corrected configuration file

Restarted Nginx

Issue 2: Website Not Loading

Possible Causes:

Port 80 not open

Nginx not running

Incorrect public IP

Fixes:

Verified Security Group rules

Restarted Nginx

Checked public IP in AWS console

Issue 3: SSH Permission Error

Cause:

Incorrect .pem file permissions

Solution:

chmod 400 devops-ec2-key.pem
📋 9. Key Commands Used
Command	Purpose
systemctl	Manage services
nginx -t	Test configuration
ufw allow	Configure firewall
chmod 400	Secure key file
ssh	Connect to server
📚 10. Key Learnings

Understanding of cloud-based virtual machines

Practical knowledge of Linux server management

Experience with web server deployment

Hands-on debugging of real issues

Knowledge of layered security systems

🔄 11. Comparison with Previous Project
Feature	S3 Static Hosting	EC2 Deployment
Server	Not required	Required
Setup	Simple	Complex
Control	Limited	Full
Use Case	Static websites	Dynamic/Custom apps
💰 12. Cost Consideration

EC2 t2.micro is free under AWS Free Tier

Limited to 750 hours/month

Running multiple instances may incur cost

Recommendation:

Stop instance when not in use

🧹 13. Cleanup

Stop instance to save free-tier usage

Terminate instance when project is complete

📅 14. Project Timeline
Day	Task
Day 1	EC2 setup and SSH
Day 2	Nginx installation
Day 3	Website deployment
📌 15. Conclusion

This project successfully demonstrates how to deploy a website on a cloud server using AWS EC2 and Nginx. It provides foundational knowledge required for roles such as Cloud Engineer and DevOps Engineer.

The hands-on experience gained includes infrastructure setup, server configuration, and troubleshooting—key skills in real-world environments.

🚀 16. Future Enhancements

Configure domain using DNS

Implement HTTPS using SSL certificates

Automate deployment using CI/CD pipelines

Use Docker for containerized deployment