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

Each plugin includes invocation examples in its own README. Typical prompts look like:

- `Add Scalekit OAuth 2.1 auth to this MCP server`
- `Integrate Scalekit agent auth for Gmail and Slack`
- `Implement enterprise SSO with Scalekit in this app`

## Install In Codex

1. Clone this repository locally.
2. In Codex, add a local plugin marketplace that points to [`/Users/saif/Projects/ai-first/codex-auth-stack/.agents/plugins/marketplace.json`](/Users/saif/Projects/ai-first/codex-auth-stack/.agents/plugins/marketplace.json).
3. Open the marketplace in Codex and install one of the plugins:
   - `mcp-auth`
   - `agent-auth`
   - `modular-sso`
   - `modular-scim`
   - `full-stack-auth`
4. Restart or reload Codex if the client asks for it.
5. Try one of the sample prompts from the installed plugin README.

## Quick Smoke Test

After installing `mcp-auth`, ask Codex:

```text
Add Scalekit OAuth 2.1 auth to this MCP server
```

You should see Codex pick up the `adding-mcp-oauth` skill and guide the workflow described in [`plugins/mcp-auth/README.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/mcp-auth/README.md).

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
