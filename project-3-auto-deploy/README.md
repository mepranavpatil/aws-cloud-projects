🚀 Project 3 — DevOps Auto Deploy Pipeline (Day 1)
📌 Overview

This project demonstrates the foundation of a DevOps deployment pipeline by integrating:

Local development environment

GitHub (source control)

AWS EC2 (compute)

Nginx (web server)

The workflow enables updating a live website by pushing code to GitHub and pulling changes on the EC2 server.

🎯 Objectives

Set up a clean DevOps project from scratch

Push application code to GitHub

Clone repository on EC2

Deploy website using Nginx

Establish manual deployment workflow (Git-based)

🏗️ Architecture
Developer (Local Machine)
        ↓ git push
GitHub Repository
        ↓ git clone / pull
AWS EC2 (Ubuntu)
        ↓ copy files
Nginx Web Server
        ↓
User Browser (Public IP)
🧰 Tech Stack
Component	Purpose
AWS EC2	Virtual server
Ubuntu 22.04	Operating system
Nginx	Web server
Git & GitHub	Version control
SSH	Remote access
📁 Project Structure
project-3-auto-deploy/
├── app/
│   └── index.html
├── .gitignore
└── README.md
🚀 Implementation Steps
1. Local Project Setup
cd aws-cloud-projects
rm -rf project-3-auto-deploy

mkdir project-3-auto-deploy
cd project-3-auto-deploy
mkdir app
2. Create Website
code app/index.html

Added custom UI-based DevOps pipeline page

Includes deployment flow visualization

3. Create .gitignore
*.pem
*.key
.env
*.log
.vscode/
4. Initialize Git & Push to GitHub
git init
git add .
git commit -m "Project 3: Initial setup"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/devops-auto-deploy.git
git push -u origin main
5. Launch & Connect to EC2
ssh -i ~/.ssh/devops-ec2-key.pem ubuntu@<PUBLIC-IP>
6. Prepare EC2 (Clean Setup)
sudo rm -rf /home/ubuntu/devops-auto-deploy
sudo rm -rf /var/www/html/*
7. Install Git
sudo apt update -y
sudo apt install git -y
8. Clone Repository
cd /home/ubuntu
git clone https://github.com/YOUR-USERNAME/devops-auto-deploy.git
9. Deploy to Nginx
sudo cp -r /home/ubuntu/devops-auto-deploy/app/* /var/www/html/
10. Restart Nginx
sudo systemctl restart nginx
11. Access Website
http://<PUBLIC-IP>

Expected: DevOps Pipeline UI loads

🔄 Deployment Flow (Manual)

Modify code locally

Push to GitHub

SSH into EC2

Pull latest code

Copy files to Nginx

Restart Nginx

🧪 Testing Workflow
Update Website

Edit:

<p class="version">Version: 1.0</p>

Change to:

<p class="version">Version: 1.1 — Updated via GitHub</p>
Push Changes
git add .
git commit -m "Update version"
git push origin main
Pull on EC2
cd /home/ubuntu/devops-auto-deploy
git pull origin main
Redeploy
sudo cp -r app/* /var/www/html/
sudo systemctl restart nginx
Verify

Refresh browser

Updated version should appear

🐞 Troubleshooting Guide
🔴 Website Not Loading
sudo systemctl status nginx

If stopped:

sudo systemctl start nginx
🔴 Changes Not Reflecting

Run:

git pull origin main

Then redeploy:

sudo cp -r app/* /var/www/html/
sudo systemctl restart nginx
🔴 Browser Shows Old Version

Hard refresh:

CTRL + SHIFT + R
🔴 Permission Issues
sudo chmod -R 755 /var/www/html
🔴 Git Clone Fails

Check repo URL

Ensure repository is public

📚 Key Learnings

Difference between code update and deployment

Git-based deployment workflow

Server-side file management

Nginx serving static content

Debugging deployment issues

🔥 Real-World Insight

This is a manual CI/CD pipeline.

In production, this becomes:

GitHub Actions / Jenkins

Automated build & deploy

Zero manual SSH

💰 Cost Consideration

Uses existing EC2 (Free Tier eligible)

No additional AWS services required

🧹 Cleanup

Stop EC2 instance when not in use

Avoid unnecessary cost

📅 Progress
Day	Task	Status
Day 1	Git + EC2 + Deployment Flow	✅ Completed
Day 2	Automation Script	⏳ Pending
Day 3	Auto Trigger (Cron/Webhook)	⏳ Pending
📌 Conclusion
This project establishes a complete CI/CD foundation by connecting development, version control, and deployment environments. Starting from manual 4-command deployments, we automated the process down to zero commands using Bash scripting and Cron scheduling.

This mirrors production deployment pipelines: Push → Pull → Deploy → Serve.