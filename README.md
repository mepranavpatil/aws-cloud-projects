# Project 1: Secure Static Website Hosting on AWS (S3 + CloudFront with OAC)

## 1. Introduction

This project implements a secure and scalable static website hosting solution on AWS using Amazon S3 and Amazon CloudFront. The architecture ensures that the S3 bucket remains private while content is delivered globally through CloudFront using Origin Access Control (OAC).

This setup reflects real-world production practices where security, performance, and controlled access are critical.

---

## 2. Architecture Overview

```text
Client → CloudFront (CDN) → Private S3 Bucket
```

### Key Components

* **Amazon S3**: Stores static website assets
* **Amazon CloudFront**: Provides CDN capabilities and HTTPS delivery
* **Origin Access Control (OAC)**: Restricts direct access to S3

---

## 3. Project Objectives

* Deploy a static website using S3
* Restrict public access to the S3 bucket
* Configure CloudFront for content delivery
* Implement secure access using OAC
* Troubleshoot and resolve access-related issues

---

## 4. Prerequisites

* AWS account
* Basic understanding of cloud services
* Static website files (HTML, CSS, JavaScript)

---

## 5. Project Structure

```text
project-root/
├── index.html
├── style.css
└── script.js
```

---

## 6. Step-by-Step Implementation

### 6.1 Create S3 Bucket

1. Navigate to S3 in AWS Console
2. Create a bucket with a globally unique name
3. Select region
4. Enable:

   * Block Public Access (all settings ON)

---

### 6.2 Upload Website Files

* Upload `index.html` and related assets
* Ensure:

  * `index.html` is at root
  * File names are correct and case-sensitive

---

### 6.3 Create CloudFront Distribution

1. Navigate to CloudFront
2. Create a new distribution

#### Origin Configuration

* Use S3 REST endpoint:

  ```
  <bucket-name>.s3.<region>.amazonaws.com
  ```
* Do NOT use S3 website endpoint

#### Viewer Configuration

* Redirect HTTP to HTTPS

---

### 6.4 Configure Origin Access Control (OAC)

1. Create a new OAC
2. Enable request signing
3. Attach OAC to the origin

This ensures only CloudFront can access S3.

---

### 6.5 Apply Bucket Policy

Attach the following policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontAccess",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<BUCKET-NAME>/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::<ACCOUNT-ID>:distribution/<DISTRIBUTION-ID>"
        }
      }
    }
  ]
}
```

---

### 6.6 Set Default Root Object

In CloudFront settings:

```
Default root object: index.html
```

---

### 6.7 Invalidate CloudFront Cache

```
/*
```

This ensures latest content is served.

---

## 7. Testing and Validation

| Test Case      | Expected Result |
| -------------- | --------------- |
| Direct S3 URL  | Access Denied   |
| CloudFront URL | Website loads   |

---

## 8. Issues Faced and Debugging

### 8.1 AccessDenied Error

**Root Causes:**

* Incorrect SourceArn in bucket policy
* OAC not attached properly
* Incorrect origin endpoint

**Resolution:**

* Corrected policy with proper Account ID and Distribution ID
* Reattached OAC with request signing enabled
* Switched to S3 REST endpoint

---

### 8.2 Default Page Not Loading

**Cause:**

* Default root object not configured

**Fix:**

* Set `index.html` as root object

---

### 8.3 Changes Not Reflecting

**Cause:**

* CloudFront caching

**Fix:**

* Performed cache invalidation

---

## 9. Security Implementation

* S3 bucket is fully private
* Access allowed only via CloudFront
* IAM policy scoped with SourceArn condition
* HTTPS enforced at CDN level

---

## 10. Cost Considerations

* S3: Free tier eligible
* CloudFront: Free tier available
* Suitable for low-traffic applications with minimal cost

---

## 11. Key Learnings

* Difference between S3 website endpoint and REST endpoint
* Secure integration between CloudFront and S3
* Importance of Origin Access Control (OAC)
* Handling AWS permission errors effectively
* Understanding CDN caching and invalidation

---

## 12. Future Improvements

* Custom domain integration
* SSL certificate configuration
* CI/CD pipeline for automated deployments
* Monitoring and logging setup

---

## 13. Final Outcome

* Secure static website deployed
* Global content delivery via CloudFront
* No direct public access to S3
* Production-style architecture implemented

---

## 14. Author

Pranav Patil
Final Year Engineering Student
Focus: Cloud Computing and DevOps

---

## 15. Project Significance

This project demonstrates practical cloud engineering skills including:

* Secure architecture design
* AWS service integration
* Troubleshooting real-world issues

It aligns directly with responsibilities expected in Cloud Support and DevOps roles.

---
