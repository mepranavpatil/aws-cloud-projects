# Origin Access Control (OAC) Security Notes

## What Changed on Day 3

### Before (Insecure)
S3 Bucket: PUBLIC
Access: Anyone on internet
Policy: Principal = "*" (everyone)
Hosting: S3 Static Website Hosting enabled
Entry Points: TWO (S3 direct + CloudFront)


### After (Secure)
S3 Bucket: PRIVATE
Access: CloudFront ONLY
Policy: Principal = "cloudfront.amazonaws.com"
Hosting: S3 Static Website Hosting DISABLED
Entry Points: ONE (CloudFront only)


## OAC Configuration
- **OAC Name:** pranav-static-site-OAC
- **Signing Behavior:** Sign requests
- **Origin Type:** S3

## New Bucket Policy
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::pranav-static-site-001/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::ACCOUNT-ID:distribution/DISTRIBUTION-ID"
                }
            }
        }
    ]
}

