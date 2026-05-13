# MCP Auth Troubleshooting

Reference for diagnosing and resolving common Scalekit MCP auth integration issues. Covers handshake/metadata verification, cached client state, CORS/network problems, and client-specific quirks.

## Principles

- Always collect evidence first (HTTP status, headers, URLs, logs) before suggesting fixes.
- Prefer reversible fixes (config, allowlists, callback URLs, proxy rules) over code changes.
- Follow the triage flow in order — earlier steps catch the most common failures.

## Triage flow

### 1. Identify the client and environment

Determine which MCP client is failing: MCP Inspector, MCP-Remote, VS Code, Codex, Claude Desktop, or another client.

Capture:
- MCP server URL
- Scalekit environment URL
- Whether this is dev or prod

### 2. Confirm the auth handshake (server-side)

Goal: verify the server challenges unauthenticated requests correctly and points clients to resource metadata.

Run these checks:

```bash
# Should return HTTP 401
curl -s -o /dev/null -w "%{http_code}" https://<mcp-server-url>/

# Should include WWW-Authenticate header with resource_metadata URL
curl -s -I https://<mcp-server-url>/ | grep -i www-authenticate
```

Then open the `resource_metadata` URL in a browser and confirm the JSON matches the Scalekit dashboard configuration for that environment.

If these checks fail, classify as **metadata/handshake misconfiguration** and fix the protected resource metadata wiring first.

### 3. Check cached client state

If the handshake looks correct but the client still fails, suspect cached old domain/metadata after a domain change.

Clear cached auth by client:
- **MCP-Remote**: delete `~/.mcp-auth/mcp-remote-<version>` and reconnect
- **VS Code**: run "Authentication: Remove Dynamic Authentication Provider", remove the cached entry, reconnect

### 4. CORS and callback URL issues

Common with MCP Inspector. If you see CORS failures during the handshake in browser network logs:

1. In Scalekit Dashboard → Authentication → Redirect URLs → Allowed Callback URLs
2. Add the client's callback URL (e.g., `http://localhost:6274/` for MCP Inspector)
3. Retry the connection

### 5. Network / proxy / firewall blocks

If MCP client calls don't reach the server:

- Identify whether behind Cloudflare, AWS WAF, or corporate proxy
- Allow or exempt MCP client → server traffic for the server domain
- Confirm via proxy/WAF logs
- Test direct connectivity from the same machine running the MCP client

### 6. Client-specific: port limitations

Some MCP clients (e.g., Claude Desktop) only support standard HTTPS on port 443 and will ignore custom ports.

Workarounds:
- Expose MCP server on 443 via a load balancer or reverse proxy
- Use a reverse proxy that listens on 443 and forwards to the internal custom port

### 7. Client-specific: browser not invoked during auth

If authentication times out because the browser never opens:

- **macOS**: allow the MCP client to open applications (System Preferences → Security & Privacy → App Management), then restart
- **Windows**: enable default app management permissions (Settings → Privacy → App permissions), then restart
- **Linux**: ensure `xdg-open` exists (`which xdg-open`) and is on PATH, then restart

## Verification checklist

After applying a fix, verify:

1. Unauthenticated request returns HTTP 401 with `WWW-Authenticate` header
2. Resource metadata URL returns valid JSON matching dashboard config
3. MCP client successfully completes the OAuth handshake
4. At least one MCP tool call succeeds end-to-end

## Related references

- [scalekit-mcp-server.md](scalekit-mcp-server.md) — Scalekit MCP server architecture and implementation patterns
- [Adding MCP OAuth skill](../skills/adding-mcp-oauth/SKILL.md) — implementing OAuth 2.1 for MCP servers
