---
name: adding-mcp-oauth
description: Guides users through adding OAuth 2.1 authorization to Model Context Protocol servers using Scalekit. Use when the user mentions MCP security, OAuth, protected-resource metadata, MCP hosts like Claude Desktop or Cursor, or a need to secure tools exposed over HTTP.
---

# Adding OAuth 2.1 Authorization To MCP Servers

Use this skill when an MCP server needs standards-based authorization for AI hosts.

## Critical Prerequisite

OAuth-capable MCP auth requires HTTP-based transport. A stdio-only MCP server cannot complete the browser and callback flows needed for OAuth 2.1.

- Node.js: use `StreamableHTTPServerTransport`
- Python: expose an ASGI app with streamable HTTP support
- Keep your well-known metadata reachable over HTTPS

## Required Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`

Get these from the Scalekit dashboard after registering the MCP server.

## Working Checklist

```text
MCP OAuth Setup:
- [ ] Install Scalekit SDK
- [ ] Register the MCP server in Scalekit
- [ ] Publish /.well-known/oauth-protected-resource
- [ ] Add token validation middleware
- [ ] Test from an MCP host
```

## Recommended Flow

1. Confirm the server is already using HTTP transport.
2. Register the MCP server in Scalekit and enable the features needed for host registration.
3. Add `/.well-known/oauth-protected-resource` with the authorization server metadata from Scalekit.
4. Add bearer-token extraction and validation on MCP routes, while leaving well-known endpoints public.
5. Return `401` with a `WWW-Authenticate` header that points to the protected-resource metadata whenever auth is missing or invalid.
6. Test from the real host integration instead of only with raw curl requests.

## Node.js Pattern

```ts
import { Scalekit } from '@scalekit-sdk/node';

const scalekit = new Scalekit(
  process.env.SCALEKIT_ENVIRONMENT_URL!,
  process.env.SCALEKIT_CLIENT_ID!,
  process.env.SCALEKIT_CLIENT_SECRET!
);

const RESOURCE_ID = 'https://mcp.yourapp.com';
const METADATA_ENDPOINT =
  'https://mcp.yourapp.com/.well-known/oauth-protected-resource';

export async function authMiddleware(req, res, next) {
  if (req.path.includes('.well-known')) return next();

  const authHeader = req.headers.authorization;
  const token = authHeader?.startsWith('Bearer ')
    ? authHeader.slice('Bearer '.length).trim()
    : null;

  if (!token) {
    return res
      .status(401)
      .set(
        'WWW-Authenticate',
        `Bearer realm="OAuth", resource_metadata="${METADATA_ENDPOINT}"`
      )
      .end();
  }

  await scalekit.validateToken(token, { audience: [RESOURCE_ID] });
  next();
}
```

## Python Pattern

```python
from scalekit import ScalekitClient
import os

client = ScalekitClient(
    env_url=os.getenv("SCALEKIT_ENVIRONMENT_URL"),
    client_id=os.getenv("SCALEKIT_CLIENT_ID"),
    client_secret=os.getenv("SCALEKIT_CLIENT_SECRET"),
)

RESOURCE_ID = "https://mcp.yourapp.com"

async def verify_token(token: str):
    return client.validate_access_token(token, {"audience": [RESOURCE_ID]})
```

## Protected-Resource Metadata

Your metadata endpoint should include:

- `authorization_servers`
- `bearer_methods_supported`
- `resource`
- `resource_documentation`
- `scopes_supported`

Source these values from the Scalekit dashboard for the registered MCP resource instead of inventing them manually.

## Guardrails

- Never implement OAuth on top of stdio transport and expect hosts to make it work.
- Keep the resource identifier used in token validation aligned with the resource metadata you publish.
- Treat missing tokens, expired tokens, and wrong audiences as host-facing auth errors with actionable responses.
