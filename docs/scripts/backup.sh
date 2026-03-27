#!/usr/bin/env bash

set -eu

# Create a timestamped backup archive for the deployed static site and related configuration.

SITE_DIR="${SITE_DIR:-/var/www/histesting}"
NGINX_SITE="${NGINX_SITE:-/etc/nginx/sites-available/histesting}"
LOG_DIR="${LOG_DIR:-/var/log/nginx}"
SSL_DIR="${SSL_DIR:-/etc/letsencrypt}"
BACKUP_ROOT="${BACKUP_ROOT:-/var/backups/histesting}"

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    SUDO="${SUDO:-sudo}"
fi

timestamp="$(date +%Y%m%d-%H%M%S)"
archive_name="histesting-backup-$timestamp.tar.gz"
archive_path="$BACKUP_ROOT/$archive_name"
tmp_dir="/tmp/histesting-backup-$timestamp"

log() {
    printf '%s\n' "$1"
}

copy_if_exists() {
    src="$1"
    dst="$2"
    if [ -e "$src" ]; then
        $SUDO mkdir -p "$(dirname "$dst")"
        $SUDO cp -a "$src" "$dst"
    fi
}

$SUDO mkdir -p "$BACKUP_ROOT"
$SUDO rm -rf "$tmp_dir"
$SUDO mkdir -p "$tmp_dir/site" "$tmp_dir/nginx" "$tmp_dir/logs"

log "Collecting deployed site files"
copy_if_exists "$SITE_DIR/." "$tmp_dir/site"

log "Collecting Nginx site configuration"
copy_if_exists "$NGINX_SITE" "$tmp_dir/nginx/$(basename "$NGINX_SITE")"

log "Collecting Nginx logs"
copy_if_exists "$LOG_DIR/." "$tmp_dir/logs"

if [ -d "$SSL_DIR" ]; then
    log "Collecting optional SSL data"
    $SUDO mkdir -p "$tmp_dir/ssl"
    copy_if_exists "$SSL_DIR/." "$tmp_dir/ssl"
fi

log "Creating archive: $archive_path"
$SUDO tar -czf "$archive_path" -C "$tmp_dir" .

log "Verifying archive integrity"
tar -tzf "$archive_path" >/dev/null

log "Backup completed successfully"
log "Archive: $archive_path"

$SUDO rm -rf "$tmp_dir"
