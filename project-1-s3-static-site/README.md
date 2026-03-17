# 🌐 Static Website Hosting on AWS S3

## 📌 Project Overview

This project demonstrates how to host a static website using **Amazon S3**, a highly scalable object storage service from AWS. The website is publicly accessible via an S3 website endpoint.

This is a foundational cloud project relevant for roles like **Cloud Support Engineer** and **DevOps Engineer**, focusing on storage, access control, and basic deployment.

---

## 🏗️ Architecture

* Static website files (HTML, CSS) are stored in an S3 bucket
* S3 serves the website using static hosting feature
* Public access is enabled via bucket policy

---

## 🛠️ Technologies Used

* AWS S3 (Static Website Hosting)
* HTML5 / CSS3
* AWS Management Console

---

## 🚀 Deployment Steps

### 1. Create an S3 Bucket

* Navigate to S3 in AWS Console
* Create a bucket with a globally unique name
* Select region (e.g., ap-south-1)
* Disable "Block all public access"

### 2. Upload Website Files

* Upload `index.html` (and other assets if any)

### 3. Enable Static Website Hosting

* Go to **Properties**
* Enable **Static Website Hosting**
* Set:

  * Index document: `index.html`

### 4. Configure Bucket Policy

Add the following policy to allow public read access:

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

### 5. Access the Website

* Use the S3 website endpoint URL from the **Properties** tab
* Example:

```
http://your-bucket-name.s3-website-region.amazonaws.com
```

---

## 🧪 Testing & Validation

* Verify website loads successfully
* Check browser console for errors
* Test incorrect configurations:

  * Remove bucket policy → expect **403 Forbidden**
  * Change index file name → expect **404 Not Found**

---

## ⚠️ Common Issues & Fixes

| Issue         | Cause              | Solution                     |
| ------------- | ------------------ | ---------------------------- |
| 403 Forbidden | No public access   | Update bucket policy         |
| 404 Not Found | Missing index.html | Upload correct file          |
| Access Denied | Permissions issue  | Check public access settings |

---

## 💡 Key Learnings

* Understanding of object storage (S3)
* Static website hosting concepts
* Access control using bucket policies
* Debugging real-world cloud issues

---

## 📈 Future Improvements

* Integrate CDN using CloudFront
* Add custom domain using Route 53
* Enable HTTPS
* Add monitoring using CloudWatch

---

## 👨‍💻 Author

Pranav Patil

---

## 📄 License

This project is for educational purposes.
