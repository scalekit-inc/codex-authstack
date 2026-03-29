# Agent Auth

`agent-auth` helps Codex integrate Scalekit connected-account flows so agents can call third-party APIs on behalf of users. It is best for Gmail, Slack, Notion, calendar, and similar connector-backed agent workflows.

## Use This Plugin When

- an agent needs delegated access to a third-party service
- you need to create or fetch connected accounts
- you need authorization links and token refresh handling
- you want to review connector setup and downstream API calls

## Primary Skill

- `integrating-agent-auth`

## Additional Skills

- `agent-auth`
- `building-agent-mcp-server`
- `production-readiness-scalekit`

Try asking Codex:

- `Integrate Scalekit agent auth for Gmail`
- `Set up a connected account flow for Slack`
- `Review my agent token refresh handling`

## Configuration

- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`
- `SCALEKIT_ENV_URL`

Most connectors must be created in the Scalekit dashboard before code integration. Gmail is the main exception for quick-start testing.

The plugin also ships [`./.mcp.json`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/.mcp.json), which points at the remote Scalekit MCP server.

## Reference Docs

- Connector catalog: [`references/agent-connectors/README.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/references/agent-connectors/README.md)
- Connected accounts: [`references/connected-accounts.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/references/connected-accounts.md)
- Connections: [`references/connections.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/references/connections.md)
- Providers: [`references/providers.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/references/providers.md)
- BYOC: [`references/byoc.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/references/byoc.md)
- Code samples: [`references/code-samples.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/agent-auth/references/code-samples.md)

## Troubleshooting

- Always fetch the connected account again before making an API call so you use the latest refreshed token.
- Match the dashboard connection name exactly in code.
- If a connected account never becomes `ACTIVE`, inspect the authorization link flow before debugging API calls.
