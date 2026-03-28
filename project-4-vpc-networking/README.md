🌐 Project 4 — AWS VPC + Networking
A hands-on AWS networking project where a custom VPC was built from scratch with public and private subnets, internet gateway, route tables, NAT gateway, and EC2 instances deployed across both subnet types.

AWS VPC
AWS EC2
Ubuntu
Nginx
Status

📌 Project Overview
Field	Detail
Objective	Build a custom VPC with public and private networking
AWS Services	VPC, Subnets, IGW, NAT Gateway, Route Tables, EC2
OS	Ubuntu Server 22.04 LTS
Instance Type	t2.micro (Free Tier)
Web Server	Nginx
Region	ap-south-1 (Mumbai)
Difficulty	Intermediate
Cost	Free (except NAT Gateway — deleted after testing)
🎯 Objectives
Build a custom VPC from scratch
Create public and private subnets
Configure internet access using Internet Gateway
Set up route tables for proper traffic flow
Launch EC2 in public subnet with Nginx
Launch EC2 in private subnet without public access
Use NAT Gateway for private subnet outbound internet
Understand bastion/jump host access pattern
Learn troubleshooting for common networking issues
🏗️ Final Architecture
text

┌──────────────────────────────────────────────────────────────┐
│                        INTERNET                              │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────┐
│                  Internet Gateway (devops-igw)               │
└──────────────────────────┬───────────────────────────────────┘
                           │
┌──────────────────────────┴───────────────────────────────────┐
│                                                              │
│                   VPC: devops-vpc (10.0.0.0/16)              │
│                                                              │
│  ┌─────────────────────────┐  ┌─────────────────────────┐    │
│  │    PUBLIC SUBNET        │  │    PRIVATE SUBNET       │    │
│  │    10.0.1.0/24          │  │    10.0.2.0/24          │    │
│  │                         │  │                         │    │
│  │  ┌───────────────────┐  │  │  ┌───────────────────┐  │    │
│  │  │ vpc-public-server │  │  │  │ vpc-private-server│  │    │
│  │  │ Ubuntu + Nginx    │  │  │  │ Ubuntu            │  │    │
│  │  │ Public IP: Yes    │  │  │  │ Public IP: No     │  │    │
│  │  │ Private: 10.0.1.x │  │  │  │ Private: 10.0.2.x │  │    │
│  │  └───────────────────┘  │  │  └───────────────────┘  │    │
│  │                         │  │                         │    │
│  │  ┌───────────────────┐  │  │                         │    │
│  │  │ NAT Gateway       │  │  │                         │    │
│  │  │ (for private      │◄─┼──┼─── 0.0.0.0/0 route     │    │
│  │  │  subnet outbound) │  │  │                         │    │
│  │  └───────────────────┘  │  │                         │    │
│  │                         │  │                         │    │
│  │  Route: 0.0.0.0/0→IGW   │  │  Route: 0.0.0.0/0→NAT   │    │
│  └─────────────────────────┘  └─────────────────────────┘    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
🧰 Tech Stack
Component	Purpose
AWS VPC	Isolated private network
Subnets	Network segmentation (public/private)
Internet Gateway	Internet access for public subnet
NAT Gateway	Outbound internet for private subnet
Route Tables	Traffic routing rules
EC2	Virtual servers
Security Groups	Instance-level firewall
Ubuntu 22.04	Operating system
Nginx	Web server
SSH	Secure remote access
📁 Project Files
text

project-4-vpc-networking/
├── README.md           # This file
├── vpc-notes.md        # Quick reference notes
└── .gitignore          # Git ignore file
📅 Day 1 — Create VPC + Subnets
Understanding VPC Concepts
What is a VPC?

VPC (Virtual Private Cloud) is your own private network inside AWS. Think of it as a house with walls that separates your resources from everyone else.

What is a Subnet?

A subnet is a smaller network inside your VPC. Like rooms inside a house.

Public Subnet: Can reach internet directly
Private Subnet: Cannot reach internet directly
What is CIDR?

CIDR defines IP address ranges:

10.0.0.0/16 = 65,536 IP addresses (for VPC)
10.0.1.0/24 = 256 IP addresses (for subnet)
10.0.2.0/24 = 256 IP addresses (for another subnet)
Step 1: Create VPC
text

AWS Console → VPC → Your VPCs → Create VPC

Settings:
  VPC only (not "VPC and more")
  Name tag: devops-vpc
  IPv4 CIDR: 10.0.0.0/16
  IPv6: No
  Tenancy: Default

Click: Create VPC
Step 2: Enable DNS Hostnames
text

Select: devops-vpc
Actions → Edit VPC settings
Check: Enable DNS hostnames
Click: Save
Step 3: Create Public Subnet
text

VPC → Subnets → Create subnet

VPC ID: devops-vpc
Subnet name: public-subnet
Availability Zone: ap-south-1a
IPv4 CIDR: 10.0.1.0/24

Click: Create subnet
Step 4: Enable Auto-Assign Public IP for Public Subnet
text

Select: public-subnet
Actions → Edit subnet settings
Check: Enable auto-assign public IPv4 address
Click: Save
Step 5: Create Private Subnet
text

VPC → Subnets → Create subnet

VPC ID: devops-vpc
Subnet name: private-subnet
Availability Zone: ap-south-1a
IPv4 CIDR: 10.0.2.0/24

Click: Create subnet
Note: Do NOT enable auto-assign public IP for private subnet.

Day 1 Verification
text

VPC Dashboard → Your VPCs:
  devops-vpc (10.0.0.0/16) ✅

VPC Dashboard → Subnets:
  public-subnet (10.0.1.0/24) - Auto-assign IP: Yes ✅
  private-subnet (10.0.2.0/24) - Auto-assign IP: No ✅
📅 Day 2 — Internet Gateway + Route Tables
Understanding IGW and Route Tables
What is Internet Gateway (IGW)?

IGW is the front door of your VPC. Without it, nothing can enter or leave from the internet.

What is a Route Table?

Route tables are like road signs that tell traffic where to go:

10.0.0.0/16 → local = traffic within VPC stays within VPC
0.0.0.0/0 → IGW = all other traffic goes to internet
What makes a subnet public vs private?

It's the route table, not the name:

Public: Has route 0.0.0.0/0 → IGW
Private: No route to IGW
Step 1: Create Internet Gateway
text

VPC → Internet gateways → Create internet gateway

Name tag: devops-igw

Click: Create internet gateway
Step 2: Attach IGW to VPC
text

Select: devops-igw
Actions → Attach to VPC
Select: devops-vpc
Click: Attach internet gateway
Step 3: Create Public Route Table
text

VPC → Route tables → Create route table

Name: public-rt
VPC: devops-vpc

Click: Create route table
Step 4: Add Internet Route to Public Route Table
text

Select: public-rt
Routes tab → Edit routes → Add route

Destination: 0.0.0.0/0
Target: Internet Gateway → devops-igw

Click: Save changes
Step 5: Associate Public Subnet with Public Route Table
text

Select: public-rt
Subnet associations tab → Edit subnet associations
Check: public-subnet
Click: Save associations
Step 6: Create Private Route Table
text

VPC → Route tables → Create route table

Name: private-rt
VPC: devops-vpc

Click: Create route table
Step 7: Associate Private Subnet with Private Route Table
text

Select: private-rt
Subnet associations tab → Edit subnet associations
Check: private-subnet
Click: Save associations
Note: Do NOT add internet route to private route table.

Day 2 Verification
text

Route Tables:

public-rt:
  Routes:
    10.0.0.0/16 → local ✅
    0.0.0.0/0 → devops-igw ✅
  Associations: public-subnet ✅

private-rt:
  Routes:
    10.0.0.0/16 → local ✅
    (no internet route) ✅
  Associations: private-subnet ✅

Internet Gateway:
  devops-igw → Attached to devops-vpc ✅
📅 Day 3 — EC2 in Public Subnet + Nginx
Step 1: Launch EC2 in Public Subnet
text

EC2 → Launch instance

Name: vpc-public-server
AMI: Ubuntu Server 22.04 LTS
Instance type: t2.micro
Key pair: devops-ec2-key (existing)

Network settings → Edit:
  VPC: devops-vpc
  Subnet: public-subnet
  Auto-assign public IP: Enable

Security Group: Create new
  Name: vpc-public-sg
  Rules:
    SSH (22) → My IP
    HTTP (80) → 0.0.0.0/0

Storage: 8 GiB gp3

Click: Launch instance
Step 2: SSH Into Public EC2
Bash

ssh -i ~/.ssh/devops-ec2-key.pem ubuntu@PUBLIC-IP
Step 3: Test Internet Access
Bash

ping -c 4 google.com
Expected output:

text

64 bytes from 142.250.xx.xx: time=1.xx ms
4 packets transmitted, 4 received, 0% packet loss
Step 4: Verify Network Details
Bash

# Check private IP (should be 10.0.1.x)
hostname -I

# Check public IP
curl -s ifconfig.me
Step 5: Update System
Bash

sudo apt update -y
sudo apt upgrade -y
Step 6: Install Nginx
Bash

sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
Step 7: Create Custom Web Page
Bash

sudo nano /var/www/html/index.html
Paste this content:

HTML

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VPC Public Server</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0a0a1a, #1a1a3e);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .container {
            text-align: center;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 60px 40px;
            border: 1px solid rgba(255,255,255,0.2);
            max-width: 650px;
            width: 90%;
        }
        .icon { font-size: 60px; margin-bottom: 20px; }
        .badge {
            display: inline-block;
            background: linear-gradient(135deg, #00b4d8, #0077b6);
            padding: 5px 18px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        h1 {
            font-size: 2.2rem;
            margin-bottom: 10px;
            background: linear-gradient(90deg, #00b4d8, #90e0ef);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .subtitle { color: #999; margin-bottom: 25px; }
        .info-box {
            background: rgba(255,255,255,0.05);
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }
        .info-box p {
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .info-box p:last-child { border-bottom: none; }
        .label { color: #00b4d8; font-weight: bold; }
        .footer { margin-top: 25px; color: #555; font-size: 0.85rem; }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">🌐</div>
        <span class="badge">Project 4 — Custom VPC</span>
        <h1>VPC Public Server</h1>
        <p class="subtitle">Running inside a custom VPC on AWS</p>

        <div class="info-box">
            <p><span class="label">🏗️ VPC:</span> devops-vpc (10.0.0.0/16)</p>
            <p><span class="label">📍 Subnet:</span> public-subnet (10.0.1.0/24)</p>
            <p><span class="label">🚪 Gateway:</span> devops-igw</p>
            <p><span class="label">🛣️ Route:</span> 0.0.0.0/0 → IGW</p>
            <p><span class="label">🖥️ Server:</span> Nginx on Ubuntu 22.04</p>
        </div>

        <p class="footer">Built with ❤️ — VPC Networking Project</p>
    </div>
</body>
</html>
Save: Ctrl + O → Enter → Ctrl + X

Step 8: Test in Browser
text

Open: http://PUBLIC-IP

You should see the custom VPC Public Server page.
Day 3 Verification
text

✅ EC2 launched in public subnet
✅ SSH access working
✅ Internet access working (ping google.com)
✅ Private IP is 10.0.1.x
✅ Nginx installed and running
✅ Website accessible from browser
📅 Day 4 — Private EC2 + NAT Gateway
Understanding NAT Gateway
The Problem:

Private EC2 has no internet access. But it needs to:

Download security updates
Install packages
Reach external APIs
The Solution: NAT Gateway

NAT Gateway is a one-way door:

Outbound works: Private EC2 → NAT → IGW → Internet ✅
Inbound blocked: Internet → Private EC2 ❌
NAT Gateway must be placed in the PUBLIC subnet because it needs IGW access.

Cost Warning:

NAT Gateway costs $0.045/hour ($32/month). We create it, test it, then delete it.

Step 1: Allocate Elastic IP
text

VPC → Elastic IPs → Allocate Elastic IP address
Click: Allocate
Step 2: Create NAT Gateway
text

VPC → NAT gateways → Create NAT gateway

Name: devops-nat
Subnet: public-subnet (MUST be public)
Connectivity: Public
Elastic IP: Select the one just created

Click: Create NAT gateway
Wait for Status: Available (1-3 minutes)

Step 3: Update Private Route Table
text

VPC → Route tables → Select private-rt
Routes tab → Edit routes → Add route

Destination: 0.0.0.0/0
Target: NAT Gateway → devops-nat

Click: Save changes
Step 4: Launch EC2 in Private Subnet
text

EC2 → Launch instance

Name: vpc-private-server
AMI: Ubuntu Server 22.04 LTS
Instance type: t2.micro
Key pair: devops-ec2-key

Network settings → Edit:
  VPC: devops-vpc
  Subnet: private-subnet
  Auto-assign public IP: Disable

Security Group: Create new
  Name: vpc-private-sg
  Rules:
    SSH (22) → Custom → 10.0.0.0/16

Storage: 8 GiB gp3

Click: Launch instance
Important: SSH source is 10.0.0.0/16 (entire VPC), not "My IP". Because we SSH from public EC2, not from internet.

Step 5: Copy SSH Key to Public EC2
We need the .pem key on public EC2 to SSH into private EC2.

Method 1: Using SCP

On your laptop (new terminal):

Bash

scp -i "path/to/devops-ec2-key.pem" "path/to/devops-ec2-key.pem" ubuntu@PUBLIC-EC2-IP:/home/ubuntu/
Method 2: Manual Copy (if SCP has issues)

On public EC2:

Bash

nano devops-ec2-key.pem
On your laptop, open .pem file in notepad, copy all content.

Paste into nano on public EC2.

Save: Ctrl + O → Enter → Ctrl + X

Set permissions:

Bash

chmod 400 devops-ec2-key.pem
Step 6: SSH from Public EC2 to Private EC2
First, get private EC2's private IP from AWS Console (something like 10.0.2.xx).

On public EC2:

Bash

ssh -i devops-ec2-key.pem ubuntu@PRIVATE-EC2-IP
Example:

Bash

ssh -i devops-ec2-key.pem ubuntu@10.0.2.45
Step 7: Verify You Are on Private EC2
Bash

hostname -I
Expected: 10.0.2.xx

Step 8: Test Internet via NAT Gateway
Bash

ping -c 4 google.com
Expected:

text

64 bytes from 142.250.xx.xx: time=1.xx ms
4 packets transmitted, 4 received, 0% packet loss
Step 9: Test Package Download
Bash

sudo apt update -y
If this works, NAT Gateway is functioning correctly.

Step 10: Exit Both Servers
Bash

exit   # Exit private EC2
exit   # Exit public EC2
Day 4 Cleanup (IMPORTANT — Save Money)
Delete NAT Route from Private Route Table
text

VPC → Route tables → private-rt
Routes → Edit routes
Delete: 0.0.0.0/0 → devops-nat
Save changes
Delete NAT Gateway
text

VPC → NAT gateways → devops-nat
Actions → Delete NAT gateway
Type: delete
Confirm
Release Elastic IP
text

VPC → Elastic IPs
Select the IP → Actions → Release Elastic IP address
Confirm
Stop EC2 Instances
text

EC2 → Instances
Select both instances → Actions → Instance state → Stop
Day 4 Verification
text

✅ NAT Gateway created in public subnet
✅ Private route table updated with NAT route
✅ Private EC2 launched with no public IP
✅ SSH to private EC2 via public EC2 (jump host)
✅ Private EC2 can ping google.com
✅ Private EC2 can run apt update
✅ NAT Gateway deleted after testing
✅ Elastic IP released
✅ EC2 instances stopped
🐞 Troubleshooting Guide
Problem: Cannot SSH into Public EC2
Possible Causes:

Security group doesn't allow SSH from your IP
Instance not in public subnet
No public IP assigned
Route table missing IGW route
Solutions:

text

Check 1: Security Group
  EC2 → Security Groups → vpc-public-sg
  Inbound rules must have: SSH (22) from Your IP

Check 2: Subnet
  EC2 → Instance → Networking tab
  Subnet should be: public-subnet

Check 3: Public IP
  Instance should have a public IP
  If not, subnet auto-assign might be off

Check 4: Route Table
  VPC → Route tables → public-rt
  Must have: 0.0.0.0/0 → devops-igw
Problem: Website Not Loading in Browser
Possible Causes:

Nginx not running
Security group missing HTTP rule
Using https instead of http
Solutions:

Bash

# Check Nginx
sudo systemctl status nginx

# If not running
sudo systemctl start nginx
text

Check security group has HTTP (80) from 0.0.0.0/0
text

Use http://PUBLIC-IP not https://
Problem: SSH to Private EC2 Timeout
Possible Causes:

Wrong security group source
Not connecting from public EC2
Wrong private IP
Solutions:

text

Check 1: Security Group Source
  vpc-private-sg must have:
  SSH (22) from 10.0.0.0/16
  
  NOT from "My IP" — that's your home IP
  You're connecting from public EC2 (10.0.1.x)
text

Check 2: Connection Source
  Must SSH from public EC2, not your laptop
  
  Your laptop → Public EC2 → Private EC2
text

Check 3: Private IP
  AWS Console → EC2 → vpc-private-server
  Copy the Private IPv4 address exactly
Problem: Private EC2 Cannot Reach Internet
Possible Causes:

NAT Gateway not created
NAT Gateway in wrong subnet
Private route table missing NAT route
Solutions:

text

Check 1: NAT Gateway exists and is Available
  VPC → NAT gateways → devops-nat → Status: Available

Check 2: NAT Gateway in public subnet
  NAT Gateway must be in public-subnet, not private-subnet

Check 3: Route table has NAT route
  VPC → Route tables → private-rt
  Routes: 0.0.0.0/0 → devops-nat
Problem: SCP Command Not Working
Error: Path issues or connection refused

Solutions:

For paths with spaces, use quotes:

Git Bash:

Bash

scp -i "/c/Users/Your Name/path/key.pem" "/c/Users/Your Name/path/key.pem" ubuntu@IP:/home/ubuntu/
PowerShell:

PowerShell

scp -i "C:\Users\Your Name\path\key.pem" "C:\Users\Your Name\path\key.pem" ubuntu@IP:/home/ubuntu/
Alternative: Manual copy method

Open .pem file in notepad → Copy all content → Paste into nano on EC2

📋 Resource Summary
VPC Configuration
Resource	Name	Details
VPC	devops-vpc	10.0.0.0/16
Public Subnet	public-subnet	10.0.1.0/24
Private Subnet	private-subnet	10.0.2.0/24
Internet Gateway	devops-igw	Attached to VPC
NAT Gateway	devops-nat	Deleted after testing
Public Route Table	public-rt	Routes to IGW
Private Route Table	private-rt	Local only (NAT removed)
EC2 Configuration
Instance	Subnet	Public IP	Purpose
vpc-public-server	public-subnet	Yes	Web server / Jump host
vpc-private-server	private-subnet	No	Internal server
Security Groups
Security Group	Port	Source	Purpose
vpc-public-sg	22	My IP	SSH access
vpc-public-sg	80	0.0.0.0/0	HTTP access
vpc-private-sg	22	10.0.0.0/16	SSH from VPC only
📚 Key Concepts Learned
Concept	Description
VPC	Your private isolated network in AWS
Subnet	Smaller network segment inside VPC
Public Subnet	Has route to Internet Gateway
Private Subnet	No direct internet route
Internet Gateway	Enables internet access for VPC
NAT Gateway	One-way outbound internet for private subnet
Route Table	Rules that direct network traffic
CIDR	IP address range notation
Bastion/Jump Host	Public server used to access private servers
Security Group	Instance-level firewall rules
💰 Cost Considerations
Resource	Cost
VPC	Free
Subnets	Free
Internet Gateway	Free
Route Tables	Free
EC2 t2.micro	Free (750 hrs/month for 12 months)
NAT Gateway	~$0.045/hour — Delete after testing
Elastic IP (attached)	Free
Elastic IP (unattached)	Costs money — Release if not using
Always:

Stop EC2 instances when not using
Delete NAT Gateway after testing
Release unused Elastic IPs
📈 Progress
Day	Task	Status
Day 1	VPC + Subnets created	✅ Completed
Day 2	Internet Gateway + Route Tables	✅ Completed
Day 3	EC2 in Public Subnet + Nginx	✅ Completed
Day 4	Private EC2 + NAT Gateway Testing	✅ Completed
Day 5	Security Groups + NACLs	⏳ Pending
Day 6	Multi-Tier Architecture	⏳ Pending
Day 7	Final Testing + Cleanup	⏳ Pending
📌 Conclusion
This project built a complete AWS VPC network from scratch, demonstrating:

How to create isolated private networks in AWS
The difference between public and private subnets
How internet access works via Internet Gateway
How private resources can reach internet via NAT Gateway
How to securely access private servers through a jump host
Real-world troubleshooting for common networking issues
This architecture pattern is used in production environments where web servers are public-facing while databases and internal services remain private and protected.

🔗 Related Projects
Project	Focus
Project 1	S3 Static Hosting + CloudFront CDN
Project 2	EC2 + Nginx Web Server
Project 3	Auto Deploy Pipeline (CI/CD)
Project 4	VPC + Networking
Built with ❤️ while learning AWS Cloud and DevOps