# AGENTS.md

This repository is a monorepo of Codex plugins intended for marketplace distribution.
Any agent changing this repo must follow this document.

## What this repo contains

Everything under `plugins/` is a Codex plugin. A plugin includes skills and reference files that teach the agent how to integrate Scalekit authentication.

Codex does not have a public plugin marketplace. This repo ships with a bootstrap installer (`install.sh`) and a local install script (`scripts/install_codex_marketplace.sh`) that copy plugins into `~/.codex/marketplaces/scalekit-auth-stack`.

## Monorepo layout

```
codex-authstack/
├── plugins/
│   ├── agentkit/                 # AI agent authentication
│   │   ├── README.md
│   │   ├── skills/              # Skill entrypoints
│   │   └── references/          # Deep docs and connector notes
│   └── saaskit/                 # B2B SaaS authentication
│       ├── README.md
│       ├── skills/
│       └── references/
├── scripts/
│   ├── install_codex_marketplace.sh
│   └── validate_marketplace.py
├── install.sh                    # One-command bootstrap installer
├── AGENTS.md                     # This file
└── README.md
```

## Plugins

### agentkit

Authentication for AI agents. OAuth flows, token vault, 40+ connectors, tool discovery.

Skills:
- `integrating-agentkit` — core integration: SDK setup, connected accounts, OAuth flows, token fetching, agent frameworks
- `discovering-connector-tools` — live tool metadata discovery, schema inspection, tool set narrowing
- `exposing-agentkit-via-mcp` — expose AgentKit tools through MCP for compatible runtimes
- `production-readiness-agentkit` — production readiness checklist for AgentKit integrations

References: `agent-connectors/` (connector docs), `connected-accounts.md`, `code-samples.md`, `providers.md`, `connections.md`, `byoc.md`, `redirects.md`

### saaskit

Production-ready auth for B2B SaaS apps. Login, sessions, SSO, SCIM, MCP server auth.

Skills:
- `implementing-saaskit` — core auth flow (+ Go, Spring Boot, Laravel reference files)
- `implementing-saaskit-nextjs` — Next.js App Router auth
- `implementing-saaskit-python` — Django, FastAPI, Flask (+ framework reference files)
- `implementing-modular-sso` — enterprise SSO (SAML/OIDC) with 20+ IdPs, admin portal
- `implementing-scim-provisioning` — SCIM 2.0 webhooks, user/group lifecycle
- `implementing-access-control` — server-side RBAC
- `managing-saaskit-sessions` — token storage, validation, refresh, revocation
- `adding-mcp-oauth` — OAuth 2.1 for MCP servers (+ Express, FastAPI, FastMCP reference files)
- `adding-api-auth` — API keys and client credentials for M2M auth
- `migrating-to-saaskit` — incremental migration from existing auth systems
- `production-readiness-saaskit` — unified production checklist

References: `bring-your-own-auth.md`, `redirects.md`, `scalekit-logs.md`, `scalekit-mcp-server.md`, `scalekit-user-profiles.md`

## Non-negotiable rules

- Work on one plugin at a time unless the user explicitly asks for cross-plugin changes.
- Never add secrets, tokens, credentials, or private endpoints to any file.
- Prefer minimal changes that improve correctness, security, and user clarity.
- Keep instructions stable, avoid time-dependent guidance.
- Use forward slashes in all paths.

## Codex-specific conventions

Codex plugins differ from Claude Code and Cursor plugins:

- **No `.claude-plugin/` or `.cursor-plugin/` directory.** Codex uses `~/.agents/plugins/marketplace.json` to discover marketplaces.
- **No rules (`.mdc` files).** Codex does not support Cursor-style rules. Use skill content and references instead.
- **No agents.** Codex does not support sub-agent definitions. Guidance that would be an agent in other auth stacks should be a skill or reference doc here.
- **No hooks.** Codex does not support lifecycle hooks.
- **No commands.** Codex does not support slash commands. Skills are the only entrypoint.

## Skill authoring rules

Each skill is a folder with `SKILL.md` as its entrypoint.

Frontmatter requirements:
- `name` must be lowercase, hyphenated, max 64 chars.
- `description` must be third person and include both what it does and when to use it.

Context budget:
- Keep `SKILL.md` short and practical.
- Put deep docs in reference files linked from `SKILL.md`.
- Do not create multi-hop reference chains.

## Validation

Run the validation script before committing:

```bash
python3 scripts/validate_marketplace.py
```

This checks marketplace manifest structure, plugin manifests, skill files, frontmatter, and reference file depth.

## Local testing

1. Run `./scripts/install_codex_marketplace.sh` to copy plugins to `~/.codex/marketplaces/scalekit-auth-stack`
2. Restart Codex
3. Open Plugin Directory and select `Scalekit Auth Stack`
4. Install `agentkit` or `saaskit`
5. Invoke at least one skill to verify it triggers correctly

## Documentation rules

Each plugin README must include:
- Purpose
- Skills list with descriptions
- Configuration (required env vars)
- Links to Scalekit docs