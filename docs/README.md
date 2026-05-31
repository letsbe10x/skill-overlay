# skill-overlay documentation

Operator and author documentation for **LAEM** (Lets Artifact Extension Model) artifacts
hosted in this repo, plus how they connect to **enterprise distribution** (PRD-048) and
the **legacy overlay** hook trees.

## Start here

| Doc | Audience | Contents |
|-----|----------|----------|
| [LAEM overview](laem-overview.md) | Everyone | Roles, stack order, overlay vs preset |
| [Public, private, and org-only extensions](public-private-org-extensions.md) | Authors, security | What belongs in this repo vs elsewhere |
| [Provenance and defense in depth](provenance-defense-in-depth.md) | Security, platform | Hash pins, policy, locks, audit trail |
| [Operator command reference](operator-command-reference.md) | Developers, SRE | CLI map + enterprise sync |
| [Use cases](use-cases.md) | PM, leads | Scenarios and recommended paths |
| [Enterprise distribution (PRD-048)](enterprise-distribution-prd-048.md) | Enterprise admins | Lifecycle, status, gaps |
| [Authoring presets in this repo](authoring-presets.md) | Contributors | Manifest, forge, PR checklist |
| [Overlay migration](overlay-migration.md) | Maintainers | Legacy `overlay.toml` → presets |

## Related repos (not duplicated here)

| Repo | Role |
|------|------|
| `core/` | `lets harness`, `lets enterprise`, lock file, apply, provenance registry |
| `skills/lets-artifact-harness/` | Canonical agent skill for harness operations |
| `ground-truth/` | ADR-040, PRD-193/048, acceptance criteria |
| `governance/schemas/` | `lets-artifact.manifest.json` JSON Schema |
| `control-plane/` | Enterprise skill-set API + admin UI |

## Shipped presets in this repo

| Preset ID | Purpose |
|-----------|---------|
| `acme-sdlc-preset` | Example / compliance append on `lets-develop-feature` |
| `lets-engineering-sdlc-preset` | Engineering SDLC bundle rules (5 skills) |
| `lets-research-studio-preset` | Research Studio skills (5 skills) |

Legacy per-skill overlays: see [profiles/lets/](../profiles/lets/) and [overlay migration](overlay-migration.md).
