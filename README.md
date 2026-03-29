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

This repository is currently meant to be cloned locally before use. The marketplace entries use local plugin paths like `./plugins/mcp-auth`, so Codex resolves them from your local checkout of this repository.

Each plugin includes invocation examples in its own README. Typical prompts look like:

- `Add Scalekit OAuth 2.1 auth to this MCP server`
- `Integrate Scalekit agent auth for Gmail and Slack`
- `Implement enterprise SSO with Scalekit in this app`

## Install In Codex

1. Clone this repository locally.
2. Keep the marketplace file at `./.agents/plugins/marketplace.json` inside the cloned repo.
3. Restart Codex.
4. Open the Plugin Directory in Codex.
5. In the marketplace picker, choose `Scalekit Auth Stack`.
6. Install one of the plugins:
   - `mcp-auth`
   - `agent-auth`
   - `modular-sso`
   - `modular-scim`
   - `full-stack-auth`
7. Try one of the sample prompts from the installed plugin README.

This follows the official Codex plugin docs for repo marketplaces: keep the marketplace at `$REPO_ROOT/.agents/plugins/marketplace.json`, restart Codex, then open the plugin directory and choose that marketplace. Reference: [Build plugins](https://developers.openai.com/codex/plugins/build).

## Quick Smoke Test

After installing `mcp-auth`, ask Codex:

```text
Add Scalekit OAuth 2.1 auth to this MCP server
```

You should see Codex pick up the `adding-mcp-oauth` skill and guide the workflow described in [`plugins/mcp-auth/README.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/mcp-auth/README.md).

## Why Clone First

Today, this marketplace is shared as a GitHub repository that users clone locally before adding it to Codex.

That is because Codex has not yet shipped:

- official public plugin publishing
- adding plugins to the official Plugin Directory
- self-serve plugin publishing and management

Once Codex supports public plugin publishing and self-serve directory management, this repo can evolve from a clone-first local marketplace into a more direct install experience.

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
