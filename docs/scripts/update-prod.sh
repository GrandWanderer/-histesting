#!/usr/bin/env bash

set -eu

# Update the production deployment from a Git checkout or a prepared source directory.

REPO_DIR="${REPO_DIR:-/opt/histesting-repo}"
SOURCE_DIR="${SOURCE_DIR:-}"
DEST_DIR="${DEST_DIR:-/var/www/histesting}"
BACKUP_ROOT="${BACKUP_ROOT:-/var/backups/histesting}"
BRANCH="${BRANCH:-main}"
NGINX_SITE="${NGINX_SITE:-/etc/nginx/sites-available/histesting}"
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

case "$DEST_DIR" in
    ""|"/")
        fail "DEST_DIR must not be empty or /."
        ;;
esac

timestamp="$(date +%Y%m%d-%H%M%S)"
backup_archive="$BACKUP_ROOT/preupdate-$timestamp.tar.gz"

$SUDO mkdir -p "$DEST_DIR" "$BACKUP_ROOT"

if [ -z "$SOURCE_DIR" ]; then
    [ -d "$REPO_DIR/.git" ] || fail "REPO_DIR is not a Git repository: $REPO_DIR"
    log "Fetching latest code from branch: $BRANCH"
    git -C "$REPO_DIR" fetch --all --prune
    git -C "$REPO_DIR" checkout "$BRANCH"
    git -C "$REPO_DIR" pull origin "$BRANCH"
    SOURCE_DIR="$REPO_DIR"
else
    log "Using prepared source directory: $SOURCE_DIR"
fi

[ -f "$SOURCE_DIR/index.html" ] || fail "index.html not found in source: $SOURCE_DIR"

if [ -n "$(find "$DEST_DIR" -mindepth 1 -maxdepth 1 2>/dev/null)" ]; then
    log "Creating pre-update backup: $backup_archive"
    $SUDO tar -czf "$backup_archive" -C "$DEST_DIR" .
fi

if command -v rsync >/dev/null 2>&1; then
    log "Synchronizing updated files"
    $SUDO rsync -av --delete \
        --exclude ".git" \
        --exclude ".github" \
        --exclude "docs" \
        --exclude "Dockerfile" \
        --exclude "docker-compose.yml" \
        --exclude "README.md" \
        --exclude "LICENSE" \
        "$SOURCE_DIR"/ "$DEST_DIR"/
else
    fail "rsync is required for update-prod.sh"
fi

log "Setting permissions"
$SUDO find "$DEST_DIR" -type d -exec chmod 755 {} \;
$SUDO find "$DEST_DIR" -type f -exec chmod 644 {} \;

if [ -f "$NGINX_SITE" ]; then
    log "Nginx site configuration detected: $NGINX_SITE"
fi

log "Validating Nginx configuration"
$SUDO nginx -t

log "Reloading Nginx"
$SUDO systemctl reload "$NGINX_SERVICE"

log "Update completed successfully"
log "Backup archive: $backup_archive"
