# Update Guide

## Purpose

This document describes how to safely update the production deployment of the static thesis landing page.

Because this is a static web project:

- database migration is not applicable;
- backend service restart is not applicable;
- cache invalidation service is not applicable.

## Preparation Before Update

1. Review the incoming changes in the repository.
2. Confirm that `index.html` and referenced static files are present.
3. Identify whether the update is routine or requires a short maintenance window.
4. Confirm server access and `sudo` privileges.
5. Prepare a rollback plan before replacing production files.

## Compatibility Check

Before updating production, verify:

- the new version is still a static site;
- no new backend dependency was introduced;
- Nginx configuration changes, if any, are understood;
- file paths referenced in HTML match the deployed directory layout;
- DNS and TLS configuration do not require changes unless planned.

## Backup Before Update

Always create a backup first.

Example:

```bash
chmod +x docs/scripts/backup.sh
sudo SITE_DIR=/var/www/histesting \
     NGINX_SITE=/etc/nginx/sites-available/histesting \
     BACKUP_ROOT=/var/backups/histesting \
     ./docs/scripts/backup.sh
```

Store the backup archive name so it can be used for rollback if needed.

## Optional Downtime Planning

Static file updates are usually fast and can often be completed without noticeable downtime. For important demonstrations or formal submission reviews, it is still good practice to:

- announce a short maintenance period;
- avoid concurrent manual edits on the server;
- keep the previous version available until verification is complete.

## Update Methods

### Method 1: Update From Git On The Server

Recommended when the server has a local repository checkout.

Example repository location:

```text
/opt/histesting-repo
```

Example update command:

```bash
chmod +x docs/scripts/update-prod.sh
sudo REPO_DIR=/opt/histesting-repo \
     DEST_DIR=/var/www/histesting \
     BRANCH=main \
     BACKUP_ROOT=/var/backups/histesting \
     NGINX_SITE=/etc/nginx/sites-available/histesting \
     ./docs/scripts/update-prod.sh
```

### Method 2: Deploy A Prepared Release

If a release artifact is prepared outside the server, copy it to a staging folder and deploy from there:

```bash
sudo SOURCE_DIR=/tmp/histesting-release \
     DEST_DIR=/var/www/histesting \
     BACKUP_ROOT=/var/backups/histesting \
     NGINX_SITE=/etc/nginx/sites-available/histesting \
     ./docs/scripts/update-prod.sh
```

## Manual Update Steps

If scripts are not used, the process is:

1. Create a backup of the current deployment.
2. Pull the latest code or copy the prepared release to the server.
3. Verify the source contains `index.html`.
4. Replace the old static files with the new version.
5. Validate Nginx configuration.
6. Reload Nginx.
7. Perform browser and command-line verification.

Example manual update using Git:

```bash
cd /opt/histesting-repo
git fetch --all --prune
git checkout main
git pull origin main
```

Sync files:

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

Validate and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## Replacing Old Static Files

Preferred method:

- use `rsync --delete` to keep production identical to the intended release.

Alternative:

- copy the new files into a clean destination directory and then repoint the Nginx `root` path if a release-based directory structure is used.

## Post-Update Verification

Run:

```bash
sudo nginx -t
systemctl status nginx
curl http://localhost
```

Then verify in a browser:

1. Open the public URL.
2. Refresh the page without cached content if needed.
3. Confirm images, CSS, and JavaScript load correctly.
4. Confirm there are no missing files or console errors.

Review logs if necessary:

```bash
sudo tail -n 50 /var/log/nginx/histesting.error.log
sudo tail -n 50 /var/log/nginx/histesting.access.log
```

## Rollback Procedure

If the updated site is broken:

1. Identify the last known good backup archive.
2. Run the restore script with that archive.
3. Validate Nginx configuration.
4. Reload Nginx.
5. Repeat verification checks.

Example:

```bash
chmod +x docs/scripts/restore.sh
sudo BACKUP_ARCHIVE=/var/backups/histesting/histesting-backup-YYYYMMDD-HHMMSS.tar.gz \
     DEST_DIR=/var/www/histesting \
     NGINX_SITE=/etc/nginx/sites-available/histesting \
     ./docs/scripts/restore.sh
```

## Database Migration Note

Database migration is not applicable to this repository because the project does not use a database.
