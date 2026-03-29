# Modular SCIM

`modular-scim` helps Codex add provisioning and deprovisioning with Scalekit Directory APIs and webhooks. It is for products that want user lifecycle sync without rewriting their existing application user model.

## Use This Plugin When

- you need SCIM-style user provisioning
- you need directory user and group sync
- you need a webhook endpoint for lifecycle events
- you want to review event mapping and idempotency

## Primary Skill

- `implementing-scim-provisioning`

## Additional Skills

- `modular-scim`
- `implementing-admin-portal`
- `production-readiness-scalekit`

Try asking Codex:

- `Add Scalekit SCIM provisioning to this app`
- `Implement a Scalekit webhook endpoint for directory sync`
- `Review my user deprovisioning flow`

## Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`
- `SCALEKIT_WEBHOOK_SECRET`

The plugin also ships [`./.mcp.json`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/modular-scim/.mcp.json), which points at the remote Scalekit MCP server.

## Reference Docs

- [`references/redirects.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/modular-scim/references/redirects.md)

## Troubleshooting

- Always verify webhook signatures before processing payloads.
- Prefer idempotent upsert and deactivate operations to avoid duplicate-event surprises.
- Keep webhook processing lightweight and move slow work to background jobs if delivery retries start piling up.
