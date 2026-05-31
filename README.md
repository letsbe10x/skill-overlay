# skill-overlay

letsbe10x augmentation for [skill-hub](https://github.com/letsbe10x/skill-hub) skills:
**LAEM presets** (composition + provenance) and **legacy overlay hooks** (pre/post injection).

## Documentation

**Full operator and author guide:** [docs/README.md](docs/README.md)

| Topic | Doc |
|-------|-----|
| LAEM roles and stack | [docs/laem-overview.md](docs/laem-overview.md) |
| Public vs private vs org-only | [docs/public-private-org-extensions.md](docs/public-private-org-extensions.md) |
| Provenance & defense in depth | [docs/provenance-defense-in-depth.md](docs/provenance-defense-in-depth.md) |
| CLI command map | [docs/operator-command-reference.md](docs/operator-command-reference.md) |
| Use cases | [docs/use-cases.md](docs/use-cases.md) |
| Enterprise / PRD-048 status | [docs/enterprise-distribution-prd-048.md](docs/enterprise-distribution-prd-048.md) |
| Author a public preset | [docs/authoring-presets.md](docs/authoring-presets.md) |
| Legacy overlay migration | [docs/overlay-migration.md](docs/overlay-migration.md) |

Agent skill (harness operations): `skills/lets-artifact-harness/` in the `skills` repo.

## Structure

```
profiles/
  lets/
    presets/                    # LAEM presets (preferred)
      <preset-id>/
        lets-artifact.manifest.json
        compositions/
    <skill-name>/               # Legacy overlay hooks
      overlay.toml
      hooks/
scripts/
  compose-skill.sh              # legacy manual compose (prefer lets skill sync)
docs/                           # operator + author documentation
```

## Quick start — LAEM preset

```bash
lets harness init
lets harness add ./profiles/lets/presets/lets-engineering-sdlc-preset
lets harness list
lets skill sync
```

## Quick start — legacy overlay (until migrated)

`lets skill sync` fetches base skills from skill-hub and composes them with matching
`overlay.toml` hooks. Prefer migrating to presets — see [docs/overlay-migration.md](docs/overlay-migration.md).

```bash
lets skill sync --skill lets-develop-feature
```

Manual compose (deprecated):

```bash
./scripts/compose-skill.sh \
  --skill lets-develop-feature \
  --profile lets \
  --output /tmp/rendered-skills
```

## Enterprise (org-only distribution)

Public presets in this repo are **voluntary**. HQ-mandated rollouts use the control-plane
skill-set lifecycle and `lets enterprise sync` — not a second manifest format.

See [docs/enterprise-distribution-prd-048.md](docs/enterprise-distribution-prd-048.md).

## Shipped public presets

| Preset | Description |
|--------|-------------|
| `acme-sdlc-preset` | Example compliance append |
| `lets-engineering-sdlc-preset` | Engineering SDLC shared rules |
| `lets-research-studio-preset` | Research Studio shared rules |

## Contributing

### New LAEM preset (preferred)

See [docs/authoring-presets.md](docs/authoring-presets.md).

### Legacy overlay (maintenance only)

1. Base skill must exist in skill-hub.
2. Add `profiles/lets/<skill-name>/overlay.toml` and hooks per template below.
3. Prefer planning migration to a preset instead of expanding legacy surface.

```toml
[overlay]
schema_version = "1"
profile = "lets"
base_skill = "<skill-name>"
base_repo = "https://github.com/letsbe10x/skill-hub"

[hooks]
pre = "hooks/lets.pre.md"
post = "hooks/lets.post.md"

[anchors]
pre_after = "## Overview"
post_before = "## Outputs"

[meta]
description = "letsbe10x runtime augmentation"
maintainer = "letsbe10x"
```

### Rules

- Hooks add letsbe10x-specific behavior only (governance, context, packs).
- Never duplicate base skill content in hooks.
- No customer secrets or org-specific compliance in public PRs.
