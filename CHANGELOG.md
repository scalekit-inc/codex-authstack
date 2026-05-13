# Changelog

## Unreleased

- Consolidate 5 plugins into 2:
  - `agentkit` — AI agent authentication (replaces `agent-auth`)
  - `saaskit` — B2B SaaS authentication (replaces `full-stack-auth`, `mcp-auth`, `modular-sso`, `modular-scim`)
- Add `.mcp.json` to both plugins pointing to `https://mcp.scalekit.com`.
- Add plugin-local reference docs, including the full AgentKit connector corpus.
- Add a richer repo README for public-facing marketplace storytelling.
- Update install script to handle migration from old plugin names.
- Add `AGENTS.md` with Codex-specific plugin conventions.
- Improve installation UX:
  - Add a one-command GitHub bootstrap installer.
  - Add a safe local installer that avoids overwriting an unrelated personal marketplace by default.
