<div align="center">

<img src="./images/scalekit.jpg" alt="Scalekit" height="64">

<p><strong>Scalekit Auth Plugins for OpenAI Codex — the auth stack for agents.</strong><br>
Add SSO, SCIM, MCP Auth, agent auth, and tool-calling to your Codex projects.</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/scalekit-inc/codex-authstack/pulls)

**[📖 Documentation](https://docs.scalekit.com)** · **[💬 Slack](https://join.slack.com/t/scalekit-community/shared_invite/zt-3gsxwr4hc-0tvhwT2b_qgVSIZQBQCWRw)**

</div>

---

This repository publishes a Codex-native marketplace of Scalekit auth plugins — focused auth packages that add SSO, SCIM, MCP auth, agent auth, and tool-calling to your projects.

---

### Included Plugins

| Plugin | Description |
|--------|-------------|
| `mcp-auth` | OAuth 2.1 authorization for MCP servers — discovery endpoint, token validation, scope enforcement |
| `agent-auth` | Scalekit Agent Auth so AI agents can act in third-party apps (Gmail, Slack, Calendar, Notion) on behalf of users |
| `full-stack-auth` | Full-stack web authentication — login pages, sessions, protected routes, RBAC, and more |
| `modular-sso` | Enterprise SSO with 20+ identity providers (Okta, Entra ID, JumpCloud) via SAML/OIDC |
| `modular-scim` | SCIM 2.0 user provisioning, group sync, and directory lifecycle management |

---

### Installation

Codex doesn't have a public plugin marketplace yet. Use the one-command bootstrap installer to set up the marketplace locally:

```bash
curl -fsSL https://raw.githubusercontent.com/scalekit-inc/codex-authstack/main/install.sh | bash
```

This installer:

1. Downloads the repository from GitHub
2. Copies it to `~/.codex/marketplaces/scalekit-auth-stack`
3. Creates or updates `~/.agents/plugins/marketplace.json` when safe to do so
4. Tells you exactly what to do manually if it skips modifying your personal marketplace file

#### Local Development

If you are developing locally from a clone:

```bash
./scripts/install_codex_marketplace.sh
```

This script:

1. Copies this repo to `~/.codex/marketplaces/scalekit-auth-stack`
2. Creates or updates `~/.agents/plugins/marketplace.json` when safe to do so
3. Tells you whether Codex can immediately see `Scalekit Auth Stack` in the Plugin Directory

---

### Post-Install

After the script runs:

1. Restart Codex
2. Open the Plugin Directory in Codex
3. In the marketplace picker, choose `Scalekit Auth Stack`
4. Install one of the plugins:
   - `mcp-auth`
   - `agent-auth`
   - `modular-sso`
   - `modular-scim`
   - `full-stack-auth`
5. Try one of the sample prompts from the installed plugin README

---

### Plugin Details

#### mcp-auth

The `mcp-auth` plugin adds production-ready OAuth 2.1 authorization to any MCP server. Once installed, Codex will:

- Serve a `/.well-known/oauth-protected-resource` discovery endpoint
- Add Bearer token validation middleware that checks audience, issuer, expiry, and scopes
- Wire up per-tool scope enforcement
- Support both **Node.js** (Express / FastMCP) and **Python** (FastAPI / FastMCP)

#### agent-auth

The `agent-auth` plugin implements Scalekit Agent Auth — so your AI agents can act on behalf of users in Gmail, Slack, Notion, Google Calendar, and 40+ other connected services.

#### full-stack-auth

The `full-stack-auth` plugin adds end-to-end authentication to B2B and AI apps using Scalekit. One integration enables: social sign-in, magic links, enterprise SSO, workspaces, MCP authentication, SCIM provisioning, and user management.

#### modular-sso

The `modular-sso` plugin integrates enterprise SSO with existing user management systems. It handles IdP-initiated and SP-initiated login, attribute mapping, JIT provisioning, and enterprise customer onboarding via the admin portal.

#### modular-scim

The `modular-scim` plugin adds SCIM 2.0 directory sync to applications. It handles real-time user provisioning, deprovisioning, and group membership changes from enterprise identity providers.

---

### Prerequisites

- [Scalekit account](https://scalekit.com) with `client_id` and `client_secret`
- Codex CLI installed and configured
- Project where you want to add authentication

---

### Validation

Run the validation script to verify your marketplace setup:

```bash
python scripts/validate_marketplace.py
```

This checks:
- Marketplace manifest structure
- Plugin manifests and required fields
- Skill files and frontmatter
- Reference file depth

---

### Helpful Links

#### Documentation

- [Scalekit Documentation](https://docs.scalekit.com) — Complete guides and API reference
- [SSO Quickstart](https://docs.scalekit.com/sso/quickstart/) — Implement enterprise SSO
- [MCP Auth Guide](https://docs.scalekit.com/mcp-auth/quickstart/) — Secure MCP servers
- [Agent Auth Guide](https://docs.scalekit.com/agent-auth/quickstart/) — Authentication for AI agents

#### Resources

- [Admin Portal](https://app.scalekit.com) — Manage your Scalekit account
- [API Reference](https://docs.scalekit.com/apis) — Complete API documentation
- [Code Examples](https://docs.scalekit.com/directory/code-examples/) — Ready-to-use snippets

---

### Contributing

Contributions are welcome! Please see [AGENTS.md](AGENTS.md) for contribution guidelines.

1. Fork this repository
2. Create a branch — `git checkout -b feature/my-plugin`
3. Make your changes following the plugin structure
4. Run validation — `python scripts/validate_marketplace.py`
5. Open a Pull Request

---

### License

This project is licensed under the **MIT license**. See the [LICENSE](LICENSE) file for more information.
