# Project 2: EC2 Web Server Deployment (Day 2 – Nginx Installation & Web Access)

## 1. Overview

This document covers Day 2 of Project 2, where a web server is installed and configured on an EC2 instance. The objective is to make the server publicly accessible over HTTP and verify that it can serve web content.

This step transitions the project from infrastructure setup to application-level service delivery.

---

## 2. Objectives

* Install Nginx on EC2
* Start and enable the web server
* Configure system services
* Allow HTTP traffic via Security Groups
* Access the server from a browser using public IP

---

## 3. Prerequisites

* EC2 instance running (from Day 1)
* SSH access working
* Security Group configured with:

  * SSH (22) → My IP
  * HTTP (80) → Anywhere

---

## 4. Architecture

```text id="xt3q7v"
User → Browser → EC2 Public IP → Nginx Web Server
```

---

## 5. Implementation Steps

### 5.1 Connect to EC2

```bash id="z8llar"
ssh -i "devops.pem" ubuntu@<your-public-ip>
```

---

### 5.2 Update System Packages

```bash id="1k2y8e"
sudo apt update -y
```

This ensures the package list is up to date before installing software.

---

### 5.3 Install Nginx

```bash id="0v8b8q"
sudo apt install nginx -y
```

This installs the Nginx web server along with required dependencies.

---

### 5.4 Start Nginx Service

```bash id="k9yb6l"
sudo systemctl start nginx
```

---

### 5.5 Enable Nginx at Boot

```bash id="d5o2re"
sudo systemctl enable nginx
```

This ensures the service starts automatically after a reboot.

---

### 5.6 Verify Service Status

```bash id="5l8qv0"
sudo systemctl status nginx
```

Expected output:

```text id="qj6c3n"
active (running)
```

---

## 6. Accessing the Web Server

### Step 1: Get Public IP

From AWS Console:

* EC2 → Instances → Select instance
* Copy **Public IPv4 address**

---

### Step 2: Open in Browser

```text id="h7p2s9"
http://<your-public-ip>
```

---

## 7. Expected Result

* Default Nginx welcome page is displayed
* Confirms:

  * Server is reachable
  * Nginx is working
  * Network configuration is correct

---

## 8. Troubleshooting Guide

### Issue 1: Website not loading

**Cause:**

* Port 80 not allowed

**Fix:**

* Update Security Group:

  ```
  HTTP (80) → 0.0.0.0/0
  ```

---

### Issue 2: Connection timeout

**Cause:**

* Instance not accessible or incorrect IP

**Fix:**

* Verify instance is running
* Confirm public IP

---

### Issue 3: Nginx not running

**Check:**

```bash id="j5b6w1"
sudo systemctl status nginx
```

**Fix:**

```bash id="h4y1dp"
sudo systemctl start nginx
```

---

### Issue 4: Connection refused

**Cause:**

* Nginx service stopped

**Fix:**

```bash id="c2m9z8"
sudo systemctl restart nginx
```

---

### Issue 5: Changes not visible

**Cause:**

* Browser caching

**Fix:**

* Hard refresh (Ctrl + Shift + R)

---

## 9. Key Learnings

* Installing and managing services on Linux
* Using `systemctl` to control processes
* Understanding how web servers work
* Role of Security Groups in HTTP access
* Difference between server availability and service availability

---

## 10. Outcome

At the end of Day 2:

* EC2 instance is serving HTTP traffic
* Nginx is installed and running
* Web server is accessible via public IP

---

## 11. Next Steps

Day 3 will cover:

* Replacing default Nginx page
* Deploying a custom website
* Understanding web root directories
* Managing file permissions

---

## 12. Author

Pranav Patil
Aspiring Cloud and DevOps Engineer

---

## 13. Relevance

This step reflects real-world responsibilities where engineers must:

* Provision servers
* Install and manage services
* Ensure application availability

---
