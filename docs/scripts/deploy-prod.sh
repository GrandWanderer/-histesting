#!/usr/bin/env bash

set -eu

# Deploy static site files to the production Nginx document root.

SOURCE_DIR="${SOURCE_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
DEST_DIR="${DEST_DIR:-/var/www/histesting}"
BACKUP_ROOT="${BACKUP_ROOT:-/var/backups/histesting}"
NGINX_SERVICE="${NGINX_SERVICE:-nginx}"

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    SUDO="${SUDO:-sudo}"
fi

timestamp="$(date +%Y%m%d-%H%M%S)"
backup_archive="$BACKUP_ROOT/predeploy-$timestamp.tar.gz"

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

[ -f "$SOURCE_DIR/index.html" ] || fail "index.html not found in SOURCE_DIR: $SOURCE_DIR"

$SUDO mkdir -p "$DEST_DIR" "$BACKUP_ROOT"

if [ -n "$(find "$DEST_DIR" -mindepth 1 -maxdepth 1 2>/dev/null)" ]; then
    log "Creating backup: $backup_archive"
    $SUDO tar -czf "$backup_archive" -C "$DEST_DIR" .
fi

if command -v rsync >/dev/null 2>&1; then
    log "Deploying files with rsync"
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
    log "rsync not found; using cp without delete cleanup"
    $SUDO cp -a "$SOURCE_DIR"/. "$DEST_DIR"/
    $SUDO rm -rf "$DEST_DIR/.git" "$DEST_DIR/.github" "$DEST_DIR/docs"
    $SUDO rm -f "$DEST_DIR/Dockerfile" "$DEST_DIR/docker-compose.yml" "$DEST_DIR/README.md" "$DEST_DIR/LICENSE"
fi

log "Applying file permissions"
$SUDO find "$DEST_DIR" -type d -exec chmod 755 {} \;
$SUDO find "$DEST_DIR" -type f -exec chmod 644 {} \;

log "Validating Nginx configuration"
$SUDO nginx -t

log "Reloading Nginx"
$SUDO systemctl reload "$NGINX_SERVICE"

log "Deployment complete"
log "Source: $SOURCE_DIR"
log "Destination: $DEST_DIR"
