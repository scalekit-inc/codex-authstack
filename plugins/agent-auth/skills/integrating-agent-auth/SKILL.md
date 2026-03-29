---
name: integrating-agent-auth
description: Integrates Scalekit Agent Auth into a project to handle connector setup, authorization links, token storage, and automatic refresh for third-party services such as Gmail, Slack, Notion, and Calendar.
---

# Agent Auth Integration

Use this skill when an agent needs OAuth access to a third-party service on behalf of a user.

## Required Configuration

- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`
- `SCALEKIT_ENV_URL`

Retrieve these from the Scalekit dashboard under developer API credentials.

## Dashboard Reminder

Except for Gmail quick starts, connectors should usually be created in the Scalekit dashboard before you write code.

For most connectors:

1. Go to `Agent Auth -> Connections`
2. Create the connector
3. Save the connection name
4. Reuse that exact connection name in code

## Working Checklist

```text
Agent Auth Integration:
- [ ] Install the SDK and initialize the client
- [ ] Create or fetch a connected account
- [ ] Send the user through authorization if needed
- [ ] Fetch the connected account again before API use
- [ ] Use the access token against the third-party API
```

## Node.js Pattern

```ts
import { ScalekitClient } from '@scalekit-sdk/node';

const client = new ScalekitClient(
  process.env.SCALEKIT_ENV_URL!,
  process.env.SCALEKIT_CLIENT_ID!,
  process.env.SCALEKIT_CLIENT_SECRET!
);

const response = await client.connectedAccounts.getOrCreateConnectedAccount({
  connector: 'gmail',
  identifier: 'user_123',
});

const connectedAccount = response.connectedAccount;

if (connectedAccount?.status !== 'ACTIVE') {
  const linkResponse =
    await client.connectedAccounts.getMagicLinkForConnectedAccount({
      connector: 'gmail',
      identifier: 'user_123',
    });

  console.log(linkResponse.link);
}
```

## Python Pattern

```python
import os
import scalekit.client

client = scalekit.client.ScalekitClient(
    client_id=os.getenv("SCALEKIT_CLIENT_ID"),
    client_secret=os.getenv("SCALEKIT_CLIENT_SECRET"),
    env_url=os.getenv("SCALEKIT_ENV_URL"),
)

response = client.actions.get_or_create_connected_account(
    connection_name="gmail",
    identifier="user_123",
)
connected_account = response.connected_account
```

## Token Usage Rule

Always refresh your view of the connected account immediately before making the downstream API call. Scalekit can refresh tokens automatically, and stale cached account objects are a common source of confusion.

## Practical Review Points

- Make sure the dashboard connection name and the code-side connector identifier match.
- In web apps, redirect users to the authorization link instead of only printing it.
- For agent workflows, keep user identity stable so the same person maps to the same connected account record.
- Review token handling separately from third-party API logic so auth failures are easy to isolate.
