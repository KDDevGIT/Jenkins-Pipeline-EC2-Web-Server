#!/usr/bin/env bash
# Simple cloud-init style setup for nginx on Amazon Linux 2023
set -euxo pipefail


# Install and start nginx
sudo dnf -y update
sudo dnf -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx


# Basic landing page with instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id || true)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone || true)
HOSTNAME=$(hostname)


cat <<'HTML' | sudo tee /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>Week 19 – Jenkins + Terraform</title>
<style>body{font-family:ui-sans-serif,system-ui;max-width:720px;margin:40px auto;padding:0 16px;line-height:1.5}</style>
</head>
<body>
<h1>It works! 🚀</h1>
<p>This EC2 web server was provisioned by <strong>Terraform</strong> via a <strong>Jenkins</strong> pipeline.</p>
<ul>
<li><b>Instance ID:</b> ${INSTANCE_ID}</li>
<li><b>AZ:</b> ${AZ}</li>
<li><b>Hostname:</b> ${HOSTNAME}</li>
</ul>
</body>
</html>
HTML


# Ensure nginx serves the new page
sudo systemctl reload nginx || true