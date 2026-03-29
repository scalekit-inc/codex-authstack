---
name: modular-sso
description: Implements Modular SSO with Scalekit for applications that already manage their own users and sessions. Use when adding enterprise SSO, SAML, OIDC, IdP-initiated login, or customer onboarding flows.
---

# Implement Modular SSO

Use this skill when the product already has user management and session management, and only needs enterprise login and connection orchestration from Scalekit.

## Before You Start

Disable Full-Stack Auth in the Scalekit dashboard so the application can run in Modular SSO mode.

## Required Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`

## Working Checklist

```text
Modular SSO:
- [ ] Configure the app for modular auth mode
- [ ] Initialize the Scalekit SDK
- [ ] Generate authorization URLs
- [ ] Handle IdP-initiated login
- [ ] Process the callback
- [ ] Validate tokens and map the user
- [ ] Test enterprise onboarding
```

## Connection Routing Options

Choose one routing input and keep it consistent:

- `connectionId` for a direct enterprise connection
- `organizationId` for the customer organization
- `loginHint` when domain-based discovery is your preferred entrypoint

## Node.js Sketch

```ts
const authUrl = scalekit.getAuthorizationUrl(
  'https://yourapp.com/auth/callback',
  {
    organizationId: 'org_123',
  }
);
```

For IdP-initiated login:

```ts
const claims = await scalekit.getIdpInitiatedLoginClaims(idpInitiatedLogin);
const authUrl = scalekit.getAuthorizationUrl(
  'https://yourapp.com/auth/callback',
  {
    connectionId: claims.connection_id,
    organizationId: claims.organization_id,
    loginHint: claims.login_hint,
    state: claims.relay_state,
  }
);
```

## Review Guidance

- Treat IdP-initiated login as a translation into a secure SP-initiated flow, not as a shortcut around normal callback handling.
- Keep enterprise onboarding decisions explicit: who creates the connection, how users are mapped, and where login is initiated.
- Map validated claims into the app's existing user model and session model instead of duplicating local account logic.
