#!/usr/bin/env bash

set -eu

# Restore a backup archive created by backup.sh.

BACKUP_ARCHIVE="${BACKUP_ARCHIVE:-}"
DEST_DIR="${DEST_DIR:-/var/www/histesting}"
NGINX_SITE="${NGINX_SITE:-/etc/nginx/sites-available/histesting}"
LOG_DIR="${LOG_DIR:-/var/log/nginx}"
SSL_DIR="${SSL_DIR:-/etc/letsencrypt}"
SAFETY_BACKUP_ROOT="${SAFETY_BACKUP_ROOT:-/var/backups/histesting}"
NGINX_SERVICE="${NGINX_SERVICE:-nginx}"

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    SUDO="${SUDO:-sudo}"
fi

log() {
    printf '%s\n' "$1"
}

fail() {
    printf 'Error: %s\n' "$1" >&2
    exit 1
}

[ -n "$BACKUP_ARCHIVE" ] || fail "BACKUP_ARCHIVE must be provided"
[ -f "$BACKUP_ARCHIVE" ] || fail "Backup archive not found: $BACKUP_ARCHIVE"

case "$DEST_DIR" in
    ""|"/")
        fail "DEST_DIR must not be empty or /."
        ;;
esac

timestamp="$(date +%Y%m%d-%H%M%S)"
extract_dir="/tmp/histesting-restore-$timestamp"
safety_archive="$SAFETY_BACKUP_ROOT/pre-restore-$timestamp.tar.gz"

$SUDO mkdir -p "$extract_dir" "$SAFETY_BACKUP_ROOT"

log "Extracting backup archive"
$SUDO tar -xzf "$BACKUP_ARCHIVE" -C "$extract_dir"

if [ -d "$DEST_DIR" ] && [ -n "$(find "$DEST_DIR" -mindepth 1 -maxdepth 1 2>/dev/null)" ]; then
    log "Creating safety backup of current deployment: $safety_archive"
    $SUDO tar -czf "$safety_archive" -C "$DEST_DIR" .
fi

if [ -d "$extract_dir/site" ]; then
    log "Restoring deployed site files"
    $SUDO mkdir -p "$DEST_DIR"
    if command -v rsync >/dev/null 2>&1; then
        $SUDO rsync -av --delete "$extract_dir/site"/ "$DEST_DIR"/
    else
        $SUDO cp -a "$extract_dir/site"/. "$DEST_DIR"/
    fi
fi

if [ -f "$extract_dir/nginx/$(basename "$NGINX_SITE")" ]; then
    log "Restoring Nginx site configuration"
    $SUDO cp -a "$extract_dir/nginx/$(basename "$NGINX_SITE")" "$NGINX_SITE"
fi

if [ -d "$extract_dir/logs" ]; then
    log "Restoring logs"
    $SUDO mkdir -p "$LOG_DIR"
    $SUDO cp -a "$extract_dir/logs"/. "$LOG_DIR"/
fi

if [ -d "$extract_dir/ssl" ]; then
    log "Restoring optional SSL material"
    $SUDO mkdir -p "$SSL_DIR"
    $SUDO cp -a "$extract_dir/ssl"/. "$SSL_DIR"/
fi

log "Validating Nginx configuration"
$SUDO nginx -t

log "Reloading Nginx"
$SUDO systemctl reload "$NGINX_SERVICE"

log "Restore completed successfully"
log "Safety backup: $safety_archive"

$SUDO rm -rf "$extract_dir"
