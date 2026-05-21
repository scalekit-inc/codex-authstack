<div align="center">

<img src="./images/scalekit.jpg" alt="Scalekit" height="64">

<p><strong>Scalekit Auth Stack for OpenAI Codex — AgentKit and SaaSKit plugins.</strong><br>
Add agent auth, tool calling, SSO, SCIM, MCP auth, and session management to your Codex projects.</p>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/scalekit-inc/codex-authstack/pulls)

**[📖 Documentation](https://docs.scalekit.com)** · **[💬 Slack](https://join.slack.com/t/scalekit-community/shared_invite/zt-3gsxwr4hc-0tvhwT2b_qgVSIZQBQCWRw)**

</div>

---

Setting up auth for B2B and AI apps is complex. This marketplace adds the complete Scalekit auth stack to your projects — whether that's an AI agent, a B2B SaaS app, or an MCP server — directly from Codex.

---

### Available Plugins

| Plugin | Description |
|--------|-------------|
| **AgentKit** | Authentication for AI agents. OAuth flows, token vault, 100+ connectors (Gmail, Slack, Salesforce, etc.), tool discovery, and live testing — so agents can act on behalf of users. |
| **SaaSKit** | Production-ready auth for B2B SaaS apps. Login, sessions, SSO (Okta, Azure AD, Google), SCIM provisioning, RBAC, MCP server auth, and API key management. |

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
./scripts/install.sh
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
4. Install a plugin:
   - `agentkit` — for AI agent authentication
   - `saaskit` — for B2B SaaS authentication
5. Try one of the sample prompts from the installed plugin README

---

### Repository Structure

```
.
├── plugins/
│   ├── agentkit/         # AI agent authentication (AgentKit)
│   └── saaskit/          # B2B SaaS authentication (SaaSKit)
├── images/               # Documentation images
├── scripts/              # Install scripts
├── AGENTS.md             # Contribution guidelines
└── LICENSE               # MIT License
```

---

### Prerequisites

- [Scalekit account](https://scalekit.com) with `client_id` and `client_secret`
- Codex CLI installed and configured
- Project where you want to add authentication

> **Windows**: install.sh requires macOS or Linux (or WSL on Windows). Native Windows PowerShell install is not yet supported.

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
- [Modular SSO guide](https://docs.scalekit.com/authenticate/sso/add-modular-sso/) — Implement enterprise SSO
- [MCP Auth guide](https://docs.scalekit.com/authenticate/mcp/quickstart/) — Secure MCP servers
- [AgentKit overview](https://docs.scalekit.com/agentkit/overview.md) — Connect agents to authenticated tools

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
