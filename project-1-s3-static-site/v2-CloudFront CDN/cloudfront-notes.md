# CloudFront Configuration Notes

## Distribution Details
- **Distribution ID:** EXXXXXXXXXXXXX
- **Domain Name:** dxxxxxxxxxxxxx.cloudfront.net
- **Origin:** pranav-static-site-001.s3-website-ap-south-1.amazonaws.com
- **Status:** Enabled
- **Price Class:** All Edge Locations

## Important Settings
| Setting | Value |
|---------|-------|
| Viewer Protocol | Redirect HTTP to HTTPS |
| Allowed Methods | GET, HEAD |
| Cache Policy | CachingOptimized |
| Default Root Object | index.html |
| WAF | Disabled |

## Cache Invalidation Commands
Path: /* → Invalidate everything
Path: /index.html → Invalidate single file


## Key Learnings
1. Always use S3 WEBSITE endpoint as origin, NOT S3 REST endpoint
2. CloudFront caches content at edge locations (default 24 hours)
3. After updating files on S3, you MUST invalidate CloudFront cache
4. First 1000 invalidation paths per month are FREE
5. CloudFront provides free HTTPS with default certificate