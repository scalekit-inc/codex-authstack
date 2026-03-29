#!/usr/bin/env bash

set -euo pipefail

REPO_SLUG="${CODEX_AUTHSTACK_REPO:-scalekit-inc/codex-authstack}"
REPO_REF="${CODEX_AUTHSTACK_REF:-main}"
SOURCE_DIR="${CODEX_AUTHSTACK_SOURCE_DIR:-}"

if [[ -n "$SOURCE_DIR" ]]; then
  exec "${SOURCE_DIR%/}/scripts/install_codex_marketplace.sh"
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

ARCHIVE_URL="https://github.com/${REPO_SLUG}/archive/refs/heads/${REPO_REF}.tar.gz"
ARCHIVE_PATH="$TMP_DIR/codex-authstack.tar.gz"

echo "Downloading Scalekit Auth Stack from:"
echo "  $ARCHIVE_URL"

curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_PATH"
tar -xzf "$ARCHIVE_PATH" -C "$TMP_DIR"

EXTRACTED_DIR="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"

if [[ -z "$EXTRACTED_DIR" ]] || [[ ! -x "$EXTRACTED_DIR/scripts/install_codex_marketplace.sh" ]]; then
  echo "Failed to find installer in downloaded archive." >&2
  exit 1
fi

exec "$EXTRACTED_DIR/scripts/install_codex_marketplace.sh"
