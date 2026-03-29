# Modular SSO

`modular-sso` helps Codex implement enterprise SSO with Scalekit for applications that already manage their own users and sessions. It focuses on connection selection, callback handling, IdP-initiated login, and enterprise onboarding.

## Use This Plugin When

- your app already has user/session management
- you need SAML or OIDC enterprise SSO
- you need IdP-initiated login support
- you want guidance on onboarding customers to the right SSO connection

## Primary Skill

- `modular-sso`

Try asking Codex:

- `Add enterprise SSO with Scalekit to this app`
- `Implement IdP-initiated login handling`
- `Review my modular SSO callback flow`

## Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`

## Troubleshooting

- Disable Full-Stack Auth in the dashboard before implementing Modular SSO flows.
- Decide whether you route users by `connectionId`, `organizationId`, or `loginHint` and keep that choice consistent.
- IdP-initiated login usually fails when the initiate-login endpoint or relay-state handling is incomplete.
