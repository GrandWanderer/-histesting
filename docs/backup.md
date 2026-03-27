# Backup And Restore Guide

## Backup Strategy

This is a static web project, so the backup scope is smaller than for a dynamic application. The goal is to preserve the deployed site and the configuration required to serve it.

## What To Back Up

| Item | Why it matters |
|---|---|
| Deployed project files | Required to restore the public website content |
| Nginx site configuration | Required to restore web server routing and document root |
| SSL certificates, if used | Required to restore HTTPS quickly |
| Logs | Helpful for diagnostics, audit, and post-incident review |

Not applicable:

- database backup;
- application runtime state backup;
- cache snapshot backup.

## Recommended Backup Frequency

Example policy for a small static site:

- daily backups for `7 days`;
- weekly backups for `4 weeks`;
- monthly backups for `3 months`.

Create an additional backup:

- before each production update;
- before changing Nginx configuration;
- before certificate renewal or replacement work.

## Archive Format

Recommended format:

```text
tar.gz
```

Example archive name:

```text
histesting-backup-20260327-183000.tar.gz
```

## Retention And Rotation

Suggested manual or automated rotation policy:

- keep the last `7` daily backups;
- keep the last `4` weekly backups;
- keep the last `3` monthly backups;
- remove older archives after verifying newer backups are valid.

This rotation can be implemented with a scheduled cleanup task or handled manually in a lab environment.

## Backup Script Usage

Prepare the script:

```bash
chmod +x docs/scripts/backup.sh
```

Example execution:

```bash
sudo SITE_DIR=/var/www/histesting \
     NGINX_SITE=/etc/nginx/sites-available/histesting \
     LOG_DIR=/var/log/nginx \
     SSL_DIR=/etc/letsencrypt \
     BACKUP_ROOT=/var/backups/histesting \
     ./docs/scripts/backup.sh
```

Expected result:

- a timestamped archive is created in `/var/backups/histesting`;
- the script verifies archive readability after creation.

## Example Shell Commands

Manual archive of deployed files:

```bash
sudo tar -czf /var/backups/histesting/site-files-$(date +%Y%m%d-%H%M%S).tar.gz /var/www/histesting
```

Manual archive of Nginx configuration:

```bash
sudo tar -czf /var/backups/histesting/nginx-config-$(date +%Y%m%d-%H%M%S).tar.gz /etc/nginx/sites-available/histesting
```

Manual integrity check:

```bash
tar -tzf /var/backups/histesting/histesting-backup-YYYYMMDD-HHMMSS.tar.gz > /dev/null
```

## Integrity Verification

Each backup should be verified by:

1. confirming the archive file exists and has a reasonable size;
2. listing archive contents with `tar -tzf`;
3. checking that key paths are present, including site files and Nginx configuration;
4. optionally extracting to a temporary directory for inspection.

Example:

```bash
tar -tzf /var/backups/histesting/histesting-backup-YYYYMMDD-HHMMSS.tar.gz | head
```

## Restore Procedure

Prepare the restore script:

```bash
chmod +x docs/scripts/restore.sh
```

Example restore:

```bash
sudo BACKUP_ARCHIVE=/var/backups/histesting/histesting-backup-YYYYMMDD-HHMMSS.tar.gz \
     DEST_DIR=/var/www/histesting \
     NGINX_SITE=/etc/nginx/sites-available/histesting \
     ./docs/scripts/restore.sh
```

Restore logic:

1. extract the selected archive to a temporary directory;
2. create a safety backup of the current deployment;
3. restore site files;
4. restore Nginx configuration if included;
5. restore optional SSL material if included;
6. validate Nginx configuration;
7. reload Nginx.

## Test Restore Procedure

A backup is only useful if it can be restored. Periodically test the process in a non-production location.

Recommended test:

1. create a temporary directory such as `/tmp/histesting-restore-test`;
2. extract the archive there;
3. verify `index.html`, CSS, JS, images, and Nginx config are present;
4. if possible, point a test Nginx instance or container to the extracted site files;
5. document the restore result.

Example extraction test:

```bash
mkdir -p /tmp/histesting-restore-test
tar -xzf /var/backups/histesting/histesting-backup-YYYYMMDD-HHMMSS.tar.gz -C /tmp/histesting-restore-test
find /tmp/histesting-restore-test -maxdepth 3 -type f | sort
```

## Database Backup Note

Database backup is not applicable because this repository does not use a database.
