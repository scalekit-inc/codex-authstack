# Full-Stack Auth

`full-stack-auth` is for complete application authentication with Scalekit: login, callback, session creation, refresh, logout, and protected routes. Use it when you want Codex to help wire auth end to end instead of only solving SSO or provisioning in isolation.

## Use This Plugin When

- you need full login and callback routes
- you need session cookies or token refresh handling
- you need logout flows and protected pages
- you want a review of your auth lifecycle before going live

## Primary Skill

- `implementing-scalekit-fsa`

Try asking Codex:

- `Add Scalekit full-stack auth to this app`
- `Implement login, callback, and logout with Scalekit`
- `Review my session refresh flow`

## Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`

## Troubleshooting

- Callback URLs must exactly match the values registered in the Scalekit dashboard.
- Use HttpOnly cookies for tokens or session state and keep refresh handling off the client when possible.
- If login works but pages still act anonymous, inspect cookie scope, secure flags, and refresh fallback behavior.
