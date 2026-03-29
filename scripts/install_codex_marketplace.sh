#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

INSTALL_ROOT="${HOME}/.codex/marketplaces/scalekit-auth-stack"
PERSONAL_MARKETPLACE="${HOME}/.agents/plugins/marketplace.json"
FORCE_PERSONAL_MARKETPLACE="${FORCE_PERSONAL_MARKETPLACE:-0}"

mkdir -p "$(dirname "$INSTALL_ROOT")"
rm -rf "$INSTALL_ROOT"
mkdir -p "$INSTALL_ROOT"

cp -R "$REPO_ROOT"/. "$INSTALL_ROOT"
rm -rf "$INSTALL_ROOT/.git"

PLUGIN_BASE="./.codex/marketplaces/scalekit-auth-stack/plugins"

write_personal_marketplace() {
  mkdir -p "$(dirname "$PERSONAL_MARKETPLACE")"
  cat > "$PERSONAL_MARKETPLACE" <<EOF
{
  "name": "scalekit-auth-stack",
  "interface": {
    "displayName": "Scalekit Auth Stack"
  },
  "plugins": [
    {
      "name": "mcp-auth",
      "source": {
        "source": "local",
        "path": "${PLUGIN_BASE}/mcp-auth"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "MCP Security"
    },
    {
      "name": "agent-auth",
      "source": {
        "source": "local",
        "path": "${PLUGIN_BASE}/agent-auth"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Agent Auth"
    },
    {
      "name": "modular-sso",
      "source": {
        "source": "local",
        "path": "${PLUGIN_BASE}/modular-sso"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Enterprise SSO"
    },
    {
      "name": "modular-scim",
      "source": {
        "source": "local",
        "path": "${PLUGIN_BASE}/modular-scim"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Provisioning"
    },
    {
      "name": "full-stack-auth",
      "source": {
        "source": "local",
        "path": "${PLUGIN_BASE}/full-stack-auth"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Application Auth"
    }
  ]
}
EOF
}

existing_marketplace_name() {
  if [[ ! -f "$PERSONAL_MARKETPLACE" ]]; then
    return 1
  fi

  python3 - <<'PY' "$PERSONAL_MARKETPLACE"
import json
import sys
path = sys.argv[1]
try:
    with open(path) as f:
        payload = json.load(f)
    print(payload.get("name", ""))
except Exception:
    print("__INVALID_JSON__")
PY
}

PERSONAL_RESULT=""
if [[ ! -f "$PERSONAL_MARKETPLACE" ]]; then
  write_personal_marketplace
  PERSONAL_RESULT="created"
else
  CURRENT_NAME="$(existing_marketplace_name || true)"
  if [[ "$CURRENT_NAME" == "scalekit-auth-stack" ]] || [[ "$FORCE_PERSONAL_MARKETPLACE" == "1" ]]; then
    write_personal_marketplace
    PERSONAL_RESULT="updated"
  else
    PERSONAL_RESULT="skipped"
  fi
fi

cat <<EOF
Installed Scalekit Auth Stack into:
  $INSTALL_ROOT

EOF

if [[ "$PERSONAL_RESULT" == "created" ]]; then
  cat <<EOF
Created personal Codex marketplace:
  $PERSONAL_MARKETPLACE

Next steps:
1. Restart Codex.
2. Open the Plugin Directory.
3. Choose "Scalekit Auth Stack".
4. Install one of the plugins.
EOF
elif [[ "$PERSONAL_RESULT" == "updated" ]]; then
  cat <<EOF
Updated personal Codex marketplace:
  $PERSONAL_MARKETPLACE

Next steps:
1. Restart Codex.
2. Open the Plugin Directory.
3. Choose "Scalekit Auth Stack".
4. Install one of the plugins.
EOF
else
  cat <<EOF
Did not modify:
  $PERSONAL_MARKETPLACE

Reason:
- That file already exists and appears to belong to a different personal marketplace.
- This installer intentionally avoids overwriting someone else's personal Codex marketplace setup.

What you can do next:
1. Restart Codex.
2. Open the Plugin Directory.
3. Add or select the marketplace file at:
   $INSTALL_ROOT/.agents/plugins/marketplace.json
4. Choose "Scalekit Auth Stack" and install one of the plugins.

If you intentionally want this installer to replace your personal marketplace file, re-run:
  FORCE_PERSONAL_MARKETPLACE=1 ./scripts/install_codex_marketplace.sh
EOF
fi
