# Project 2: EC2 Web Server Deployment (Day 1 – Instance Setup & SSH Access)

## 1. Overview

This document covers Day 1 of Project 2, where the goal is to provision a virtual server on AWS and establish secure remote access using SSH.

This step forms the foundation for all further deployment activities such as installing web servers, hosting applications, and configuring CI/CD pipelines.

---

## 2. Objectives

* Launch an EC2 instance
* Configure network access (Security Groups)
* Set up SSH key-based authentication
* Connect to the server from a local machine

---

## 3. Prerequisites

* AWS account
* Basic terminal knowledge
* SSH client (PowerShell / Git Bash / WSL)

---

## 4. EC2 Instance Configuration

### Instance Details

* **Name**: devops-project-ec2
* **AMI**: Ubuntu Server 22.04 LTS
* **Instance Type**: t2.micro (Free tier eligible)

---

### Key Pair

* Create a new key pair during launch
* Type: `.pem`
* Store it securely (cannot be downloaded again)

---

### Network Configuration

Configure Security Group with the following inbound rules:

| Type | Port | Source   |
| ---- | ---- | -------- |
| SSH  | 22   | My IP    |
| HTTP | 80   | Anywhere |

---

## 5. Connecting to EC2 via SSH

### Step 1: Navigate to Key Location

```bash id="t7kz8o"
cd <path-to-your-key>
```

---

### Step 2: Fix Key Permissions (Windows)

```powershell id="s3k2q9"
icacls "devops.pem" /inheritance:r
icacls "devops.pem" /grant:r "%USERNAME%:R"
```

---

### Step 3: Connect via SSH

```bash id="t0q1ps"
ssh -i "devops.pem" ubuntu@<your-public-ip>
```

---

## 6. Expected Output

Successful connection will show:

```bash id="0f6zox"
ubuntu@ip-xxx-xxx-xxx-xxx:~$
```

---

## 7. Troubleshooting Guide

### Issue 1: chmod not recognized (Windows)

**Cause:**

* Using Linux command in PowerShell

**Solution:**
Use:

```powershell id="zj5k7d"
icacls "devops.pem" /inheritance:r
icacls "devops.pem" /grant:r "%USERNAME%:R"
```

---

### Issue 2: Permission denied (publickey)

**Cause:**

* Incorrect key permissions

**Solution:**

* Fix permissions using icacls (Windows)
* Ensure correct `.pem` file is used

---

### Issue 3: Connection timeout

**Cause:**

* Port 22 not open in Security Group

**Solution:**

* Go to EC2 → Security Group
* Allow:

  ```
  SSH (22) → My IP
  ```

---

### Issue 4: Wrong username

**Cause:**

* Using incorrect default user

**Solution:**
Use:

```bash id="6k7q1m"
ubuntu
```

---

### Issue 5: Incorrect file path

**Cause:**

* Key file not in current directory

**Solution:**
Use full path:

```bash id="2f0h9d"
ssh -i "C:\full\path\to\devops.pem" ubuntu@<IP>
```

---

### Issue 6: Connection refused

**Cause:**

* Instance not running or wrong IP

**Solution:**

* Check instance state (running)
* Verify public IP address

---

## 8. Key Learnings

* How to provision a virtual machine in AWS
* Importance of Security Groups in network access
* SSH authentication using key pairs
* Handling permission issues on Windows systems
* Differences between Linux and Windows command environments

---

## 9. Outcome

At the end of Day 1:

* EC2 instance is successfully running
* SSH access is established
* Environment is ready for server configuration

---

## 10. Next Steps

Day 2 will cover:

* Installing Nginx
* Starting a web server
* Serving a basic webpage
* Verifying HTTP access

---

## 11. Author

Pranav Patil
Aspiring Cloud and DevOps Engineer

---
