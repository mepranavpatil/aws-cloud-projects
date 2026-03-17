# 🌐 Static Website Hosting on AWS S3

![AWS](https://img.shields.io/badge/AWS-S3-orange?logo=amazon-aws)
![Status](https://img.shields.io/badge/Project-Beginner-green)
![Cost](https://img.shields.io/badge/Cost-Free%20Tier-blue)

---

## 📌 Project Overview

This project demonstrates how to deploy a **static website** using AWS S3 with public access configuration.

It is designed as a **foundational cloud project** for:

* Cloud Support Engineer roles
* DevOps Engineer roles

The project focuses on **storage, permissions, hosting, and debugging**, which are core real-world skills.

---

## 🏗️ Architecture Diagram (Simple)

```
User (Browser)
      │
      ▼
S3 Bucket (Static Website Hosting)
      │
      ▼
HTML / CSS Files (index.html)
```

---

## 🛠️ Technologies Used

* AWS S3 (Static Website Hosting)
* HTML5 / CSS3
* AWS Management Console

---

## 🚀 Deployment Steps

### 1️⃣ Create an S3 Bucket

* Go to AWS S3 Console
* Create a bucket with a **globally unique name**
* Select region (e.g., `ap-south-1`)
* Disable **Block all public access**

---

### 2️⃣ Upload Website Files

Upload:

* `index.html`
* Optional: CSS, JS files

---

### 3️⃣ Enable Static Website Hosting

* Go to **Properties**
* Enable **Static Website Hosting**
* Set:

  * Index document: `index.html`

---

### 4️⃣ Configure Bucket Policy

Allow public access using:

```json
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

### 5️⃣ Access the Website

Use the endpoint from:
**Properties → Static Website Hosting**

Example:

```
http://your-bucket-name.s3-website-region.amazonaws.com
```

---

## 💰 Cost & Billing (IMPORTANT)

### ✅ Free Tier (12 Months)

* 5 GB storage → FREE
* 20,000 GET requests → FREE
* 2,000 PUT requests → FREE

### 📊 Expected Cost for This Project

| Usage                        | Cost              |
| ---------------------------- | ----------------- |
| Static website (low traffic) | ₹0                |
| Moderate usage               | Few ₹             |
| High traffic                 | Scales with usage |

---

### ⚠️ When Charges May Occur

* High number of requests
* Large data transfer
* Additional AWS services

---

### 🔔 Best Practice (Must Do)

Set a billing alert:

* Go to AWS Billing → Budgets
* Create alert at `$1`

---

## 🧪 Testing & Debugging

| Error         | Cause              | Fix                  |
| ------------- | ------------------ | -------------------- |
| 403 Forbidden | No public access   | Update bucket policy |
| 404 Not Found | Missing index.html | Upload correct file  |
| Access Denied | Permissions issue  | Check settings       |

---

## 🧠 Key Learnings

* Object storage fundamentals
* Static website hosting
* Access control via bucket policies
* Debugging cloud issues

---

## 🔒 Security Considerations

* Avoid public access for sensitive data
* Use IAM roles for production setups
* Enable logging and monitoring in real projects

---

## 📈 Future Enhancements

* Add CDN using CloudFront
* Configure custom domain via Route 53
* Enable HTTPS (SSL)
* Add monitoring with CloudWatch

---

## 📁 Project Structure

```
project-root/
│
├── index.html
├── README.md
```

---

## 👨‍💻 Author

**Pranav Patil**

---

## ⭐ Resume Value

> Deployed a static website using AWS S3 with public access configuration and implemented basic monitoring and troubleshooting.

---

## 📄 License

This project is for educational purposes only.
