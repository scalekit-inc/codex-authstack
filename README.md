# Scalekit Auth Stack for Codex

This repository publishes a Codex-native marketplace of focused Scalekit auth plugins. The catalog is modular so teams can install only the capability they need instead of adopting one monolithic auth package.

## Included Plugins

- `mcp-auth`: OAuth 2.1 authorization for MCP servers and AI-host integrations
- `agent-auth`: connected-account flows for agents acting in third-party apps
- `modular-sso`: enterprise SSO for products that already manage users and sessions
- `modular-scim`: directory sync, provisioning, and deprovisioning workflows
- `full-stack-auth`: end-to-end login, callback, session, refresh, and logout guidance

## Marketplace Layout

- `.agents/plugins/marketplace.json` is the marketplace source of truth
- `plugins/<plugin-name>/.codex-plugin/plugin.json` defines plugin metadata
- `plugins/<plugin-name>/README.md` explains usage, setup, and troubleshooting
- `plugins/<plugin-name>/skills/<skill-name>/SKILL.md` contains the primary Codex-facing workflow
- `plugins/mcp-auth/.mcp.json` wires the remote Scalekit MCP server for the MCP plugin

## Using The Marketplace

Point Codex at [`./.agents/plugins/marketplace.json`](/Users/saif/Projects/ai-first/codex-auth-stack/.agents/plugins/marketplace.json) as a local marketplace source, then install the plugin that matches your use case.

For end users, the intended experience is a one-command bootstrap install that places the marketplace in the right local Codex directory and wires it up safely.

Each plugin includes invocation examples in its own README. Typical prompts look like:

- `Add Scalekit OAuth 2.1 auth to this MCP server`
- `Integrate Scalekit agent auth for Gmail and Slack`
- `Implement enterprise SSO with Scalekit in this app`

## Install In Codex

The simplest install flow is a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/scalekit-inc/codex-authstack/main/install.sh | bash
```

That bootstrap installer:

- downloads the repo from GitHub
- copies it to `~/.codex/marketplaces/scalekit-auth-stack`
- creates or updates `~/.agents/plugins/marketplace.json` when it is safe to do so
- avoids overwriting someone else's personal Codex marketplace setup
- tells you exactly what to do manually if it skips modifying your personal marketplace file

If you are developing locally from a clone, you can still run:

```bash
./scripts/install_codex_marketplace.sh
```

That local installer:

- copies this repo to `~/.codex/marketplaces/scalekit-auth-stack`
- creates or updates `~/.agents/plugins/marketplace.json` when it is safe to do so
- tells you whether Codex can immediately see `Scalekit Auth Stack` in the Plugin Directory

After the script runs:

1. Restart Codex.
2. Open the Plugin Directory in Codex.
3. In the marketplace picker, choose `Scalekit Auth Stack`.
4. Install one of the plugins:
   - `mcp-auth`
   - `agent-auth`
   - `modular-sso`
   - `modular-scim`
   - `full-stack-auth`
5. Try one of the sample prompts from the installed plugin README.

If you prefer the fully manual route, you can still clone this repo and use the repo-local marketplace at `./.agents/plugins/marketplace.json`.

This follows the official Codex plugin docs for repo marketplaces: keep the marketplace at `$REPO_ROOT/.agents/plugins/marketplace.json`, restart Codex, then open the plugin directory and choose that marketplace. Reference: [Build plugins](https://developers.openai.com/codex/plugins/build).

## Quick Smoke Test

After installing `mcp-auth`, ask Codex:

```text
Add Scalekit OAuth 2.1 auth to this MCP server
```

You should see Codex pick up the `adding-mcp-oauth` skill and guide the workflow described in [`plugins/mcp-auth/README.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/mcp-auth/README.md).

## Why This Installs Locally

Today, Codex plugins and marketplaces are still local installs even when they start from a GitHub repository.

That is because Codex has not yet shipped:

- official public plugin publishing
- adding plugins to the official Plugin Directory
- self-serve plugin publishing and management

Once Codex supports public plugin publishing and self-serve directory management, this repo can evolve from a bootstrap-to-local install into a more direct install experience.

## Validation

Run the local validator before packaging or publishing changes:

```bash
python3 scripts/validate_marketplace.py
```

The validator checks marketplace source paths, plugin manifests, README presence, skill presence, and name consistency.

## Notes

- Hooks are intentionally omitted because Codex does not support them yet.
- This is a Codex adaptation of the existing Scalekit auth marketplace, not a byte-for-byte Claude plugin port.
- The repo contains no secrets; plugin docs reference environment variables and dashboard setup instead of hardcoded credentials.
