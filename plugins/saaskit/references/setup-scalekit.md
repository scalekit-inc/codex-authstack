# Scalekit Setup Guide

Reference for setting up Scalekit credentials, installing the SDK, and verifying the integration works before building features.

## Required environment variables

| Variable | Where to find it |
|----------|-----------------|
| `SCALEKIT_ENVIRONMENT_URL` | [app.scalekit.com](https://app.scalekit.com) → Settings → Environment |
| `SCALEKIT_CLIENT_ID` | [app.scalekit.com](https://app.scalekit.com) → Developers → Settings → API Credentials |
| `SCALEKIT_CLIENT_SECRET` | [app.scalekit.com](https://app.scalekit.com) → Developers → Settings → API Credentials |

Store credentials in `.env`, shell environment, or CI secrets. Never hardcode them in source files.

## Setup workflow

### 1. Determine language and env var location

Identify the project's language/runtime (Node.js, Python, Go, Java) and where env vars should live (`.env`, shell profile, CI secrets).

### 2. Confirm env vars exist

Verify all three variables are set in the current shell or process:

```bash
echo $SCALEKIT_ENVIRONMENT_URL
echo $SCALEKIT_CLIENT_ID
echo $SCALEKIT_CLIENT_SECRET
```

### 3. Install the Scalekit CLI

Install the CLI globally for environment management, auth testing, and configuration commands:

```bash
npm i -g @scalekit-inc/cli
```

### 4. Install the SDK

| Language | Package |
|----------|---------|
| Node.js | `npm install @scalekit-sdk/node` |
| Python | `pip install scalekit-sdk-python` |
| Go | `go get github.com/scalekit-inc/scalekit-sdk-go/v2` |
| Java | Add `scalekit-sdk-java` to Maven/Gradle |

### 5. Initialize the client

**Python**
```python
from scalekit import ScalekitClient
import os
from dotenv import load_dotenv
load_dotenv()

sk_client = ScalekitClient(
    client_id=os.getenv("SCALEKIT_CLIENT_ID"),
    client_secret=os.getenv("SCALEKIT_CLIENT_SECRET"),
    env_url=os.getenv("SCALEKIT_ENVIRONMENT_URL"),
)
```

**Node.js**
```typescript
import { ScalekitClient } from '@scalekit-sdk/node';
import 'dotenv/config';

const scalekit = new ScalekitClient(
  process.env.SCALEKIT_ENVIRONMENT_URL!,
  process.env.SCALEKIT_CLIENT_ID!,
  process.env.SCALEKIT_CLIENT_SECRET!
);
```

### 6. Verify credentials

List organizations with a small page size as the simplest verification:

**Python**
```python
orgs = scalekit.organizations.list(page_size=5)
print(f"Connected. Found {len(orgs.organizations)} organizations.")
```

**Node.js**
```typescript
const orgs = await scalekit.organization.listOrganizations({ pageSize: 5 });
console.log(`Connected. Found ${orgs.organizations.length} organizations.`);
```

### 7. Diagnose failures

If verification fails, check in this order:

1. **Wrong environment URL** — dev vs prod, missing `https://` prefix
2. **Missing env vars** — not loaded in current shell/process, `.env` not in project root
3. **Incorrect client ID/secret** — regenerate from dashboard if unsure
4. **Network/DNS issues** — corporate proxy, firewall, or VPN blocking the request

## After setup succeeds

Route to the appropriate skill for the user's goal:

- SSO → `plugins/saaskit/skills/implementing-modular-sso/SKILL.md`
- SCIM → `plugins/saaskit/skills/implementing-scim-provisioning/SKILL.md`
- MCP server auth → `plugins/saaskit/skills/adding-mcp-oauth/SKILL.md`
- SaaSKit auth → `plugins/saaskit/skills/implementing-saaskit/SKILL.md`
- Agent auth → `plugins/agentkit/skills/integrating-agentkit/SKILL.md`
