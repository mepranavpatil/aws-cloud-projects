Here is your content cleaned up and properly structured for a professional **GitHub README.md**. Nothing has been removed—only formatted, organized, and slightly refined for clarity and readability.

---

# 🌐 Project 4 — AWS VPC + Networking

A hands-on AWS networking project where a custom VPC was built from scratch with public and private subnets, Internet Gateway, route tables, NAT Gateway, and EC2 instances deployed across both subnet types.

---

## 🧾 Project Overview

| Field             | Detail                                                |
| ----------------- | ----------------------------------------------------- |
| **Objective**     | Build a custom VPC with public and private networking |
| **AWS Services**  | VPC, Subnets, IGW, NAT Gateway, Route Tables, EC2     |
| **OS**            | Ubuntu Server 22.04 LTS                               |
| **Instance Type** | t2.micro (Free Tier)                                  |
| **Web Server**    | Nginx                                                 |
| **Region**        | ap-south-1 (Mumbai)                                   |
| **Difficulty**    | Intermediate                                          |
| **Cost**          | Free (except NAT Gateway — deleted after testing)     |

---

## 🎯 Objectives

* Build a custom VPC from scratch
* Create public and private subnets
* Configure internet access using Internet Gateway
* Set up route tables for proper traffic flow
* Launch EC2 in public subnet with Nginx
* Launch EC2 in private subnet without public access
* Use NAT Gateway for private subnet outbound internet
* Understand bastion/jump host access pattern
* Learn troubleshooting for common networking issues

---

## 🏗️ Final Architecture

```
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
```

---

## 🧰 Tech Stack

| Component        | Purpose                              |
| ---------------- | ------------------------------------ |
| AWS VPC          | Isolated private network             |
| Subnets          | Network segmentation                 |
| Internet Gateway | Internet access for public subnet    |
| NAT Gateway      | Outbound internet for private subnet |
| Route Tables     | Traffic routing rules                |
| EC2              | Virtual servers                      |
| Security Groups  | Instance-level firewall              |
| Ubuntu 22.04     | Operating system                     |
| Nginx            | Web server                           |
| SSH              | Secure remote access                 |

---

## 📁 Project Structure

```
project-4-vpc-networking/
├── README.md
├── vpc-notes.md
└── .gitignore
```

---

# 📅 Day 1 — VPC + Subnets

### Key Concepts

* **VPC** = Private network in AWS
* **Subnet** = Smaller network inside VPC
* **CIDR** defines IP ranges

```
10.0.0.0/16 → 65,536 IPs
10.0.1.0/24 → 256 IPs
10.0.2.0/24 → 256 IPs
```

### Steps

* Create VPC (`10.0.0.0/16`)
* Enable DNS hostnames
* Create:

  * Public subnet (`10.0.1.0/24`)
  * Private subnet (`10.0.2.0/24`)
* Enable auto-assign public IP only for public subnet

---

# 📅 Day 2 — IGW + Route Tables

### Concepts

* **IGW** = Internet access point
* **Route Table** = Traffic rules

### Setup

* Create & attach IGW
* Public Route Table:

  * `0.0.0.0/0 → IGW`
* Private Route Table:

  * No internet route
* Associate subnets correctly

---

# 📅 Day 3 — Public EC2 + Nginx

### Steps

* Launch EC2 in public subnet
* Allow:

  * SSH (22) → My IP
  * HTTP (80) → Anywhere

### Install Nginx

```bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
```

### Test

```
http://PUBLIC-IP
```

---

# 📅 Day 4 — Private EC2 + NAT Gateway

### Key Concept

* NAT Gateway allows:

  * Outbound internet ✅
  * Inbound blocked ❌

### Steps

* Create Elastic IP
* Create NAT Gateway (in public subnet)
* Add route:

  ```
  0.0.0.0/0 → NAT
  ```
* Launch private EC2 (no public IP)
* SSH via public EC2 (jump host)

---

## 🔐 Bastion / Jump Host Flow

```
Laptop → Public EC2 → Private EC2
```

---

## 🐞 Troubleshooting

### SSH Issues

* Check security group
* Ensure public IP exists
* Verify route table

### Website Not Loading

```bash
sudo systemctl status nginx
```

### Private EC2 Internet Issue

* NAT Gateway must be:

  * Available
  * In public subnet
* Route table must include NAT route

---

## 📋 Resource Summary

### VPC

| Resource       | Details     |
| -------------- | ----------- |
| VPC            | 10.0.0.0/16 |
| Public Subnet  | 10.0.1.0/24 |
| Private Subnet | 10.0.2.0/24 |

### EC2

| Instance       | Public IP | Purpose         |
| -------------- | --------- | --------------- |
| Public Server  | Yes       | Web + Jump Host |
| Private Server | No        | Internal        |

---

## 📚 Key Concepts Learned

* VPC isolation
* Public vs Private subnet
* Internet Gateway usage
* NAT Gateway behavior
* Route table logic
* Bastion host architecture
* Security group design

---

## 💰 Cost Considerations

| Resource     | Cost         |
| ------------ | ------------ |
| VPC          | Free         |
| EC2 t2.micro | Free tier    |
| NAT Gateway  | ~$0.045/hour |

### Best Practices

* Stop EC2 when not in use
* Delete NAT Gateway after testing
* Release unused Elastic IPs

---

## 📈 Progress

| Day   | Task                    | Status |
| ----- | ----------------------- | ------ |
| Day 1 | VPC + Subnets           | ✅      |
| Day 2 | IGW + Routing           | ✅      |
| Day 3 | Public EC2              | ✅      |
| Day 4 | Private EC2 + NAT       | ✅      |
| Day 5 | Security Groups + NACLs | ⏳      |
| Day 6 | Multi-tier Architecture | ⏳      |
| Day 7 | Final Testing           | ⏳      |

---

## 📌 Conclusion

This project demonstrates:

* Building a custom AWS network from scratch
* Designing secure public/private architectures
* Implementing controlled internet access
* Using NAT for outbound-only connectivity
* Accessing private systems securely via jump host

This is a **production-grade foundational architecture** used in real-world cloud environments.

---

## 🔗 Related Projects

| Project   | Focus           |
| --------- | --------------- |
| Project 1 | S3 + CloudFront |
| Project 2 | EC2 + Nginx     |
| Project 3 | CI/CD Pipeline  |
| Project 4 | VPC Networking  |

---

**Built while learning AWS Cloud & DevOps 🚀**
