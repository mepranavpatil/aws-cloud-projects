# AWS Static Website Hosting with Secure CloudFront (OAC)

## 1. Overview

This project demonstrates how to deploy a static website using Amazon S3 and securely distribute it through Amazon CloudFront using Origin Access Control (OAC).

The implementation follows production-grade practices by ensuring that:

* The S3 bucket is not publicly accessible
* Only CloudFront is permitted to fetch content from S3
* All traffic is served over HTTPS via a global CDN

This architecture is commonly used in real-world environments for secure and scalable static content delivery.

---

## 2. Architecture

```
Client → CloudFront Distribution → Private S3 Bucket
```

### Components

* **Amazon S3**: Stores static website assets (HTML, CSS, JS)
* **CloudFront**: CDN layer for caching, HTTPS delivery, and global distribution
* **Origin Access Control (OAC)**: Restricts S3 access to CloudFront only

---

## 3. Objectives

* Deploy a static website using S3
* Prevent direct public access to S3
* Configure CloudFront as the only access layer
* Implement secure access using OAC
* Troubleshoot and resolve real-world AWS permission errors

---

## 4. Prerequisites

* AWS account
* Basic understanding of S3 and CloudFront
* Static website files (index.html, CSS, JS)

---

## 5. Project Structure

```
project-root/
├── index.html
├── style.css
└── script.js
```

---

## 6. Implementation Guide

### Step 1: Create S3 Bucket

1. Navigate to S3 service
2. Create a new bucket with a globally unique name
3. Select your preferred region
4. Ensure:

   * Block Public Access: Enabled (all options checked)

---

### Step 2: Upload Website Files

Upload the following files to the bucket:

* index.html (entry point)
* CSS and JavaScript assets

Ensure that:

* File names are correct (case-sensitive)
* index.html exists at the root level

---

### Step 3: Create CloudFront Distribution

1. Navigate to CloudFront

2. Create a new distribution

3. Configure origin:

   * Origin domain: S3 REST endpoint (not website endpoint)
   * Example format:

     ```
     <bucket-name>.s3.<region>.amazonaws.com
     ```

4. Viewer settings:

   * Redirect HTTP to HTTPS

---

### Step 4: Configure Origin Access Control (OAC)

1. Create a new Origin Access Control
2. Enable request signing
3. Attach OAC to the CloudFront origin

This ensures that S3 only accepts requests signed by CloudFront.

---

### Step 5: Apply Bucket Policy

Attach the following policy to your S3 bucket:

```
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

This policy enforces that only the specified CloudFront distribution can access S3 objects.

---

### Step 6: Configure Default Root Object

1. Open CloudFront distribution settings
2. Set:

   ```
   Default root object = index.html
   ```

This ensures that requests to `/` return the main page.

---

### Step 7: Invalidate Cache

After configuration changes:

1. Go to CloudFront → Invalidations
2. Create invalidation:

   ```
   /*
   ```

This forces CloudFront to fetch updated content.

---

## 7. Testing and Validation

| Scenario                    | Expected Result         |
| --------------------------- | ----------------------- |
| Direct S3 object URL        | Access Denied           |
| CloudFront distribution URL | Website loads correctly |

---

## 8. Debugging and Troubleshooting

### Issue: AccessDenied Error

Common root causes:

1. Incorrect SourceArn in bucket policy
   Ensure Account ID and Distribution ID are accurate

2. OAC not attached
   Confirm that OAC is linked to the origin and request signing is enabled

3. Incorrect origin endpoint
   Must use S3 REST endpoint, not website endpoint

4. Missing default root object
   Without index.html, root requests will fail

5. CloudFront cache not refreshed
   Perform invalidation after changes

---

## 9. Security Considerations

* S3 public access is fully blocked
* Access is restricted using IAM condition keys
* Only CloudFront service is authorized
* HTTPS enforced at the CDN layer

This aligns with secure-by-default cloud architecture principles.

---

## 10. Cost Considerations

* S3 usage falls under free tier (limited storage)
* CloudFront provides free tier for initial usage
* Costs remain negligible for low-traffic projects

---

## 11. Key Learnings

* Difference between S3 website endpoint and REST endpoint
* Implementation of Origin Access Control (OAC)
* Secure content delivery using CloudFront
* Debugging AWS permission-related issues
* Understanding CDN caching behavior

---

## 12. Future Enhancements

* Configure custom domain using DNS
* Attach SSL certificate using AWS Certificate Manager
* Automate deployment using CI/CD pipeline
* Enable logging and monitoring

---

## 13. Outcome

The final setup results in:

* A globally distributed static website
* Secure backend storage (private S3)
* Controlled access through CloudFront

---

## 14. Author

Pranav Patil
Final Year Engineering Student
Focus: Cloud Computing and DevOps

---

## 15. Relevance

This project reflects real-world practices used in production environments and is directly aligned with responsibilities in Cloud Support and DevOps roles.

It demonstrates:

* Secure architecture design
* Hands-on AWS implementation
* Practical debugging experience

---
