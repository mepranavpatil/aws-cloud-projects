#!/bin/bash

echo "🚀 Starting Deployment..."

# Step 1: Go to project directory
cd /home/ubuntu/cloud/aws-cloud-projects/project-3-auto-deploy || exit

# Step 2: Pull latest code
echo "📥 Pulling latest code from GitHub..."
git pull origin main

# Step 3: Copy files to Nginx
echo "📂 Copying files to /var/www/html/..."
sudo cp -r app/* /var/www/html/

# Step 4: Restart Nginx
echo "🔄 Restarting Nginx..."
sudo systemctl restart nginx

# Step 5: Success message
echo "✅ Deployment Successful!"
echo "🌐 Visit: http://YOUR-PUBLIC-IP"