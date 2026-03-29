# Full-Stack Auth

`full-stack-auth` is for complete application authentication with Scalekit: login, callback, session creation, refresh, logout, and protected routes. Use it when you want Codex to help wire auth end to end instead of only solving SSO or provisioning in isolation.

## Use This Plugin When

- you need full login and callback routes
- you need session cookies or token refresh handling
- you need logout flows and protected pages
- you want a review of your auth lifecycle before going live

## Primary Skill

- `implementing-scalekit-fsa`

## Additional Skills

- `full-stack-auth`
- `implementing-scalekit-nextjs-auth`
- `implementing-scalekit-fastapi-auth`
- `implementing-scalekit-flask-auth`
- `implementing-scalekit-django-auth`
- `implementing-scalekit-go-auth`
- `implementing-scalekit-laravel-auth`
- `implementing-scalekit-springboot-auth`
- `implementing-access-control`
- `manage-user-sessions`
- `implement-logout`
- `adding-oauth2-to-apis`
- `adding-api-key-auth`
- `implementing-admin-portal`
- `migrating-to-scalekit-auth`
- `production-readiness-scalekit`

Try asking Codex:

- `Add Scalekit full-stack auth to this app`
- `Implement login, callback, and logout with Scalekit`
- `Review my session refresh flow`

## Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`

The plugin also ships [`./.mcp.json`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/full-stack-auth/.mcp.json), which points at the remote Scalekit MCP server.

## Reference Docs

- Redirects: [`references/redirects.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/full-stack-auth/references/redirects.md)
- Logs: [`references/scalekit-logs.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/full-stack-auth/references/scalekit-logs.md)
- User profiles: [`references/scalekit-user-profiles.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/full-stack-auth/references/scalekit-user-profiles.md)
- Migration checklist: [`skills/migrating-to-scalekit-auth/AUDIT-CHECKLIST.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/full-stack-auth/skills/migrating-to-scalekit-auth/AUDIT-CHECKLIST.md)
- Migration import samples: [`skills/migrating-to-scalekit-auth/IMPORT-SAMPLES.md`](/Users/saif/Projects/ai-first/codex-auth-stack/plugins/full-stack-auth/skills/migrating-to-scalekit-auth/IMPORT-SAMPLES.md)

## Troubleshooting

- Callback URLs must exactly match the values registered in the Scalekit dashboard.
- Use HttpOnly cookies for tokens or session state and keep refresh handling off the client when possible.
- If login works but pages still act anonymous, inspect cookie scope, secure flags, and refresh fallback behavior.
