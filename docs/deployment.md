# Production Deployment Guide

## Project Type

This repository is a static web project. It contains only frontend and content assets for a thesis landing page.

Applicable:

- web server deployment;
- static file copy or sync;
- Nginx configuration;
- optional TLS configuration.

Not applicable:

- application server deployment;
- database provisioning;
- database migration;
- cache cluster setup;
- worker process management.

## Target Environment

Primary recommended production environment:

- Ubuntu Server 22.04 LTS
- Nginx
- Git

## Minimum Hardware Recommendation

- `1 vCPU`
- `1-2 GB RAM`
- `10 GB disk`

This is sufficient because the site serves only static files.

## Software Requirements

Install the following packages on the server:

- `nginx`
- `git`
- `tar`
- `unzip`
- optional: `rsync`
- optional: `certbot` and `python3-certbot-nginx` for HTTPS

Example installation:

```bash
sudo apt update
sudo apt install -y nginx git tar unzip rsync
```

Optional HTTPS tooling:

```bash
sudo apt install -y certbot python3-certbot-nginx
```

## Network Requirements

- Port `80/tcp` open for HTTP
- Port `443/tcp` open for HTTPS
- DNS record pointing the domain or subdomain to the server IP

If `ufw` is used:

```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow OpenSSH
sudo ufw enable
```

## Recommended Folder Structure

Use a simple and predictable layout:

```text
/var/www/histesting                    # Deployed static website
/var/www/histesting/releases           # Optional release snapshots
/var/backups/histesting                # Backup archives
/etc/nginx/sites-available/histesting  # Nginx server block
/etc/nginx/sites-enabled/histesting    # Enabled Nginx link
```

Create the directories:

```bash
sudo mkdir -p /var/www/histesting
sudo mkdir -p /var/backups/histesting
sudo chown -R $USER:$USER /var/www/histesting
```

## Deployment Preparation

### Option 1: Deploy From Local Repository Copy

Clone the repository on the server:

```bash
cd /opt
sudo git clone https://github.com/GrandWanderer/-histesting.git histesting-repo
sudo chown -R $USER:$USER /opt/histesting-repo
```

### Option 2: Copy A Prepared Release

If the release is prepared elsewhere, copy the static files to the server with `scp`, `rsync`, or a CI artifact.

## Copying Or Deploying Static Files

Example using `rsync` from a repository checkout:

```bash
rsync -av --delete \
  --exclude ".git" \
  --exclude ".github" \
  --exclude "docs" \
  --exclude "Dockerfile" \
  --exclude "docker-compose.yml" \
  --exclude "README.md" \
  --exclude "LICENSE" \
  /opt/histesting-repo/ /var/www/histesting/
```

Apply recommended permissions:

```bash
sudo find /var/www/histesting -type d -exec chmod 755 {} \;
sudo find /var/www/histesting -type f -exec chmod 644 {} \;
```

## Nginx Installation And Site Configuration

Install Nginx if it is not already installed:

```bash
sudo apt update
sudo apt install -y nginx
```

Create the server block:

```bash
sudo nano /etc/nginx/sites-available/histesting
```

Example configuration:

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;

    root /var/www/histesting;
    index index.html;

    access_log /var/log/nginx/histesting.access.log;
    error_log /var/log/nginx/histesting.error.log;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }
}
```

Enable the site:

```bash
sudo ln -s /etc/nginx/sites-available/histesting /etc/nginx/sites-enabled/histesting
sudo nginx -t
sudo systemctl reload nginx
sudo systemctl enable nginx
```

If the default site conflicts, disable it:

```bash
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

## SSL Or TLS Note

HTTPS is optional for a lab environment but recommended for any internet-facing deployment.

Example with Certbot:

```bash
sudo certbot --nginx -d example.com -d www.example.com
```

After obtaining a certificate, re-run:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## Verification

Perform basic validation after deployment:

```bash
sudo nginx -t
systemctl status nginx
curl http://localhost
```

Then verify in a browser:

1. Open the public domain or server IP.
2. Confirm the landing page loads.
3. Confirm styles, images, and JavaScript work correctly.
4. Check browser developer tools for missing files or `404` responses.

## Troubleshooting Basics

### Nginx Configuration Test Fails

Use:

```bash
sudo nginx -t
```

Then review the reported line number in the Nginx configuration file.

### Blank Or Broken Styling

Check:

- the `root` path in the server block;
- file permissions in `/var/www/histesting`;
- browser console and network tab for missing CSS or image files.

### 404 Errors For Static Assets

Verify that deployment included:

- `css/`
- `js/`
- `images/`
- `robots.txt`
- `sitemap.xml`
- `site.webmanifest`

### Nginx Service Not Running

Check:

```bash
sudo systemctl status nginx
sudo journalctl -u nginx --no-pager -n 50
```

## Application Server And Database Sections

For this project, the following operational areas are intentionally not applicable:

- application server installation;
- process manager setup;
- database server installation;
- schema migration;
- cache configuration.
