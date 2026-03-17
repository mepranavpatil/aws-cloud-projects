# 🌐 Static Website Hosting on AWS S3 + CloudFront

![AWS](https://img.shields.io/badge/AWS-S3%20%7C%20CloudFront-orange?logo=amazon-aws)
![Level](https://img.shields.io/badge/Level-Beginner--to--Intermediate-green)
![Cost](https://img.shields.io/badge/Cost-Free%20Tier-blue)

---

## 📌 Project Overview

This project demonstrates how to deploy a **highly available static website** using:

* **Amazon S3** for storage
* **Amazon CloudFront** as a CDN (Content Delivery Network)

It simulates a **real-world production setup** where performance, caching, and global delivery are important.

---

## 🏗️ Architecture

```id="7b1j9s"
User (Browser)
      │
      ▼
CloudFront (CDN - Edge Locations)
      │
      ▼
S3 Bucket (Static Website Hosting - Origin)
      │
      ▼
HTML / CSS Files
```

---

## 🛠️ Technologies Used

* AWS S3 (Static Website Hosting)
* AWS CloudFront (CDN + Caching)
* HTML5 / CSS3

---

## 🚀 Deployment Steps

### 1️⃣ Create S3 Bucket

* Create bucket with unique name
* Select region (e.g., ap-south-1)
* Disable "Block all public access"

---

### 2️⃣ Upload Website Files

Upload:

* `index.html`
* Optional CSS/JS files

---

### 3️⃣ Enable Static Website Hosting

* Go to **Properties**
* Enable Static Website Hosting
* Set:

  * Index document → `index.html`

---

### 4️⃣ Add Bucket Policy

```json id="q6n9b2"
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::YOUR-BUCKET-NAME/*"]
    }
  ]
}
```

---

### 5️⃣ Create CloudFront Distribution

* Origin: S3 **website endpoint**
* Viewer Protocol Policy: Redirect HTTP → HTTPS
* Deploy distribution

---

### 6️⃣ Access Website

* S3 URL (direct)
* CloudFront URL (recommended)

Example:

```id="y7u4l3"
https://dxxxxx.cloudfront.net
```

---

## ⚡ CDN & Caching Behavior

### Without CloudFront

* Requests go directly to S3
* Higher latency

### With CloudFront

* Content served from nearest edge location
* Reduced latency
* Cached responses

---

## 💰 Cost & Billing

### Free Tier

* 5 GB storage (S3)
* 20,000 GET requests
* CloudFront includes free usage tier

### Expected Cost

| Usage            | Cost          |
| ---------------- | ------------- |
| Personal project | ₹0            |
| Moderate traffic | Minimal       |
| High traffic     | Pay-as-you-go |

---

### 🔔 Best Practice

Set billing alert:

```id="d7s0q1"
$1 budget alert
```

---

## 🧪 DEBUGGING GUIDE (REAL-WORLD SCENARIOS)

### 🔴 1. Changes Not Reflecting (MOST COMMON)

**Problem:**

* Updated file in S3 but CloudFront shows old content

**Cause:**

* Cached content at edge locations

**Solution:**

* Go to CloudFront → Invalidations
* Create:

```id="vht9k3"
/*
```

---

### 🔴 2. 403 Forbidden

**Possible Causes:**

* Bucket policy missing
* Public access blocked
* Wrong origin used

**Fix:**

* Verify bucket policy
* Ensure public access is enabled
* Use **S3 website endpoint**, not bucket endpoint

---

### 🔴 3. 404 Not Found

**Cause:**

* `index.html` missing or misnamed

**Fix:**

* Upload correct file
* Check case sensitivity

---

### 🔴 4. Access Denied

**Cause:**

* Permissions issue

**Fix:**

* Check IAM / bucket policy
* Verify object-level permissions

---

### 🔴 5. CloudFront Not Updating After Upload

**Cause:**

* Cache TTL not expired

**Fix:**

* Use invalidation
* Or reduce TTL in distribution settings

---

### 🔴 6. Slow Website Even After CloudFront

**Cause:**

* Incorrect origin configuration
* No caching applied

**Fix:**

* Verify cache behavior
* Ensure correct origin path

---

## 🧠 Key Learnings

* CDN fundamentals
* Cache vs origin behavior
* Cache invalidation strategies
* Real-world debugging scenarios

---

## 🔒 Security Considerations

* Avoid public buckets in production
* Use Origin Access Control (OAC) for CloudFront
* Enable HTTPS for secure delivery

---

## 📈 Future Enhancements

* Add custom domain using Route 53
* Enable SSL (HTTPS)
* Implement logging & monitoring
* Use Infrastructure as Code (CloudFormation/Terraform)

---

## 📁 Project Structure

```id="y5rxl0"
project-root/
│
├── index.html
├── style.css
├── README.md
```

---

## 👨‍💻 Author

**Pranav Patil**

---

## ⭐ Resume Value

> Deployed a globally distributed static website using AWS S3 and CloudFront with caching, invalidation, and debugging strategies.

---

## 📄 License

Educational use only
