#!/usr/bin/env python3
"""Validate the local Codex marketplace structure."""

from __future__ import annotations

import json
import sys
from pathlib import Path


REQUIRED_POLICY_FIELDS = {"installation", "authentication"}
MIN_SKILL_COUNT = 2
MIN_REFERENCE_COUNT = 1


def load_json(path: Path) -> dict:
    with path.open() as handle:
        return json.load(handle)


def expect(condition: bool, message: str, errors: list[str]) -> None:
    if not condition:
        errors.append(message)


def report(errors: list[str]) -> int:
    if errors:
        print("Marketplace validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print("Marketplace validation passed.")
    return 0


def main() -> int:
    repo_root = Path(__file__).resolve().parent.parent
    marketplace_path = repo_root / ".agents" / "plugins" / "marketplace.json"
    errors: list[str] = []

    expect(marketplace_path.exists(), f"Missing marketplace file: {marketplace_path}", errors)
    if errors:
        return report(errors)

    payload = load_json(marketplace_path)
    plugins = payload.get("plugins")

    expect(payload.get("name") == "scalekit-auth-stack", "Marketplace name must be scalekit-auth-stack.", errors)
    expect(
        payload.get("interface", {}).get("displayName") == "Scalekit Auth Stack",
        "Marketplace interface.displayName must be 'Scalekit Auth Stack'.",
        errors,
    )
    expect(isinstance(plugins, list) and len(plugins) > 0, "Marketplace must define a non-empty plugins array.", errors)

    if not isinstance(plugins, list):
        return report(errors)

    seen_names: set[str] = set()

    for entry in plugins:
        name = entry.get("name")
        expect(isinstance(name, str) and name, "Each marketplace entry must define a name.", errors)
        if not isinstance(name, str) or not name:
            continue

        expect(name not in seen_names, f"Duplicate marketplace plugin name: {name}", errors)
        seen_names.add(name)

        source = entry.get("source", {})
        policy = entry.get("policy", {})
        category = entry.get("category")

        expect(source.get("source") == "local", f"{name}: source.source must be 'local'.", errors)
        expect(source.get("path") == f"./plugins/{name}", f"{name}: source.path must be ./plugins/{name}.", errors)
        expect(isinstance(policy, dict), f"{name}: policy must be an object.", errors)
        if isinstance(policy, dict):
            missing_policy = REQUIRED_POLICY_FIELDS.difference(policy.keys())
            expect(not missing_policy, f"{name}: missing policy fields {sorted(missing_policy)}.", errors)
        expect(isinstance(category, str) and category, f"{name}: category must be present.", errors)

        plugin_dir = repo_root / "plugins" / name
        manifest_path = plugin_dir / ".codex-plugin" / "plugin.json"
        readme_path = plugin_dir / "README.md"

        expect(plugin_dir.exists(), f"{name}: plugin directory is missing.", errors)
        expect(manifest_path.exists(), f"{name}: missing plugin manifest.", errors)
        expect(readme_path.exists(), f"{name}: missing plugin README.", errors)

        if not manifest_path.exists():
            continue

        manifest = load_json(manifest_path)
        expect(manifest.get("name") == name, f"{name}: manifest name does not match folder name.", errors)
        expect(manifest.get("skills") == "./skills/", f"{name}: skills path must be ./skills/.", errors)

        skill_files = list(plugin_dir.glob("skills/**/SKILL.md"))
        expect(
            len(skill_files) >= MIN_SKILL_COUNT,
            f"{name}: expected at least {MIN_SKILL_COUNT} SKILL.md files, found {len(skill_files)}.",
            errors,
        )

        reference_files = [path for path in plugin_dir.glob("references/**/*") if path.is_file()]
        expect(
            len(reference_files) >= MIN_REFERENCE_COUNT,
            f"{name}: expected at least {MIN_REFERENCE_COUNT} reference document, found {len(reference_files)}.",
            errors,
        )

        if "mcpServers" in manifest:
            mcp_path = plugin_dir / ".mcp.json"
            expect(manifest.get("mcpServers") == "./.mcp.json", f"{name}: mcpServers must point to ./.mcp.json.", errors)
            expect(mcp_path.exists(), f"{name}: manifest declares mcpServers but .mcp.json is missing.", errors)

    return report(errors)


if __name__ == "__main__":
    sys.exit(main())
