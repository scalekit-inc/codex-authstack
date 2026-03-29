# Agent Auth

`agent-auth` helps Codex integrate Scalekit connected-account flows so agents can call third-party APIs on behalf of users. It is best for Gmail, Slack, Notion, calendar, and similar connector-backed agent workflows.

## Use This Plugin When

- an agent needs delegated access to a third-party service
- you need to create or fetch connected accounts
- you need authorization links and token refresh handling
- you want to review connector setup and downstream API calls

## Primary Skill

- `integrating-agent-auth`

Try asking Codex:

- `Integrate Scalekit agent auth for Gmail`
- `Set up a connected account flow for Slack`
- `Review my agent token refresh handling`

## Configuration

- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`
- `SCALEKIT_ENV_URL`

Most connectors must be created in the Scalekit dashboard before code integration. Gmail is the main exception for quick-start testing.

## Troubleshooting

- Always fetch the connected account again before making an API call so you use the latest refreshed token.
- Match the dashboard connection name exactly in code.
- If a connected account never becomes `ACTIVE`, inspect the authorization link flow before debugging API calls.
