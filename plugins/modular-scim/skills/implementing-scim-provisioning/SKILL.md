---
name: implementing-scim-provisioning
description: Implements Scalekit provisioning using the Directory API and webhook events. Use when the user needs user lifecycle sync, SCIM-style provisioning, deprovisioning, or directory-backed group management.
---

# SCIM Provisioning With Scalekit

Use this skill when the application needs automated user lifecycle management without replacing its local data model.

## Required Configuration

- `SCALEKIT_ENVIRONMENT_URL`
- `SCALEKIT_CLIENT_ID`
- `SCALEKIT_CLIENT_SECRET`
- `SCALEKIT_WEBHOOK_SECRET`

## Working Checklist

```text
SCIM Provisioning:
- [ ] Install and initialize the Scalekit SDK
- [ ] Add Directory API sync
- [ ] Add a webhook endpoint
- [ ] Verify webhook signatures
- [ ] Map directory events to local user operations
- [ ] Test create, update, and deactivate flows
```

## Node.js Sketch

```ts
const directory = await scalekit.directory.getPrimaryDirectoryByOrganizationId(
  orgId
);
const { users } = await scalekit.directory.listDirectoryUsers(orgId, directory.id);

for (const user of users) {
  await upsertUser({ email: user.email, name: user.name, orgId });
}
```

```ts
app.post('/webhooks/scalekit', async (req, res) => {
  try {
    await scalekit.verifyWebhookPayload(
      process.env.SCALEKIT_WEBHOOK_SECRET,
      req.headers,
      req.body
    );
  } catch {
    return res.status(400).json({ error: 'Invalid signature' });
  }

  await handleDirectoryEvent(req.body.type, req.body.data);
  res.status(201).json({ status: 'processed' });
});
```

## Event Mapping Guidance

Map incoming events to the app's existing user and group operations:

- `organization.directory.user_created` -> create or upsert the user
- `organization.directory.user_updated` -> update the local record
- `organization.directory.user_deleted` -> prefer deactivation over hard deletion
- group events -> sync roles, memberships, or permissions

## Operational Guardrails

- Verify webhook signatures before touching application state.
- Keep handlers idempotent because webhook retries happen.
- Return success quickly and move slow downstream work to a queue if needed.
- Reuse the application's existing user-management functions instead of creating a parallel lifecycle path.
