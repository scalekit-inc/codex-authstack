---
name: implementing-scalekit-fsa
description: Implements Scalekit full-stack authentication including login, callback, logout, secure session storage, and refresh-token handling. Use when building end-to-end authentication for a web application with Scalekit.
---

# Scalekit Full-Stack Authentication

Use this skill when you want a complete application auth flow rather than a single enterprise SSO or provisioning feature.

## Required Configuration

```text
SCALEKIT_ENVIRONMENT_URL=<your-environment-url>
SCALEKIT_CLIENT_ID=<your-client-id>
SCALEKIT_CLIENT_SECRET=<your-client-secret>
```

## Core Flow

1. Generate an authorization URL and redirect the user to Scalekit.
2. Exchange the callback code for tokens.
3. Store session state in secure server-controlled cookies.
4. Refresh access tokens when needed.
5. Clear local session state and redirect to the Scalekit logout URL.

## Node.js Sketch

```ts
const authorizationUrl = scalekit.getAuthorizationUrl(redirectUri, {
  scopes: ['openid', 'profile', 'email', 'offline_access'],
});

res.redirect(authorizationUrl);
```

```ts
const { user, idToken, accessToken, refreshToken } =
  await scalekit.authenticateWithCode(code, redirectUri);
```

```ts
res.cookie('accessToken', accessToken, {
  httpOnly: true,
  secure: true,
  sameSite: 'strict',
  path: '/api',
});
```

## Implementation Checklist

```text
Full-Stack Auth:
- [ ] Generate login URL
- [ ] Implement callback exchange
- [ ] Create secure session storage
- [ ] Add refresh-token fallback
- [ ] Add logout route
- [ ] Protect server-rendered and API routes
```

## Review Guidance

- Callback URLs must exactly match the values configured in the dashboard.
- Prefer HttpOnly cookies and server-side refresh logic over exposing tokens to the browser runtime.
- Validate access tokens first, then fall back to refresh using the refresh token.
- If refresh fails, clear local session state and require a new login.

## Cross-Language Note

Scalekit keeps the same auth lifecycle across SDKs even though method names vary slightly:

- authorization URL generation
- code exchange
- token validation
- token refresh
- logout URL generation

Use the framework and cookie abstractions already present in the target app rather than creating a parallel auth subsystem.
