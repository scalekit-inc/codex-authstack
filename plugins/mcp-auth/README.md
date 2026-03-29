# MCP Auth

`mcp-auth` helps Codex add OAuth 2.1 authorization to MCP servers using Scalekit. It is the plugin to use when you need protected tools for Claude Desktop, Cursor, VS Code, or any other MCP host that expects standards-based auth.

## Use This Plugin When

- your MCP server needs OAuth 2.1 protection
- you need `/.well-known/oauth-protected-resource`
- you need token validation middleware with Scalekit
- you want a review of an existing MCP auth flow before launch

## Primary Skill

- `adding-mcp-oauth`

Try asking Codex:

- `Add Scalekit OAuth 2.1 auth to this MCP server`
- `Implement protected-resource metadata for my MCP server`
- `Review this MCP auth integration for missing security steps`

## Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`

The plugin also ships [`./.mcp.json`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/mcp-auth/.mcp.json), which points at the remote Scalekit MCP server.

## Troubleshooting

- OAuth-capable MCP auth requires HTTP transport, not stdio transport.
- Missing or invalid bearer tokens should return `401` plus a `WWW-Authenticate` header that points hosts at your protected-resource metadata.
- Keep dashboard resource settings and your metadata endpoint aligned before debugging token validation.
