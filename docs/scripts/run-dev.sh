#!/usr/bin/env bash

set -eu

# Start a simple local server for the static site from the repository root.

PORT="${PORT:-8000}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

echo "Serving static site from: $REPO_ROOT"
echo "Local URL: http://localhost:$PORT"
echo "Stop the server with Ctrl+C"

if command -v python3 >/dev/null 2>&1; then
    exec python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
    exec python -m http.server "$PORT"
elif command -v http-server >/dev/null 2>&1; then
    exec http-server "$REPO_ROOT" -p "$PORT"
else
    echo "Error: Python 3 or Node.js http-server is required for local preview." >&2
    echo "Install Python 3, or install Node.js and then run: npm install -g http-server" >&2
    exit 1
fi
