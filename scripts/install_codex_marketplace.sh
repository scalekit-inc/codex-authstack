#!/usr/bin/env bash
# Backwards-compatible wrapper — the installer was renamed to install.sh.
exec "$(dirname "$0")/install.sh" "$@"