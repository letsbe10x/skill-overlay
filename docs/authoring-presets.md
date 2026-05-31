# Authoring presets in skill-overlay

Checklist for contributing a **public LAEM preset** under `profiles/lets/presets/`.

## Directory layout

```text
profiles/lets/presets/<preset-id>/
├── lets-artifact.manifest.json   # required
├── README.md                     # human summary
├── compositions/
│   └── <name>.md                 # referenced by manifest
└── (optional) CHANGELOG.md
```

Example: `profiles/lets/presets/lets-engineering-sdlc-preset/`.

## Manifest checklist

| Field | Guidance |
|-------|----------|
| `artifact.id` | Stable preset id (matches directory name) |
| `artifact.role` | `preset` (or `extension` if adding new capability) |
| `artifact.version` | Semver |
| `requires.targets` | Each `skill:<name>` with `role: core` you compose onto |
| `provides.compositions[]` | `target`, `section`, `file`, `strategy` |
| `distribution.source_ref` | Path in this repo |
| `distribution.content_hash` | `sha256:…` after files finalized |
| `distribution.trust_tier` | `first_party` for letsbe10x public presets |
| `governance_impact` | Honest mutation / critical path disclosure |

Schema: `governance/schemas/lets-artifact-manifest.schema.json` (in `governance` repo).

## Composition strategies

| Strategy | When |
|----------|------|
| `append` | Add compliance / methodology section at end of section |
| `prepend` | Prerequisites at start |
| `replace` | Full section replacement (use sparingly) |
| `wrap` | Template with `{CORE}` placeholder |

## Validate before PR

```bash
# From skill-forge repo (or workspace with forge installed)
forge check --harness ./profiles/lets/presets/<preset-id>
```

## Update content hash

After changing compositions or manifest:

```python
# From core dev env
from pathlib import Path
from letsbe10x.harness.hashutil import sha256_prefixed
root = Path("profiles/lets/presets/<preset-id>")
print(sha256_prefixed(root))
```

Set `distribution.content_hash` in manifest to the printed value.

## PR requirements

1. Matching base skills exist in [skill-hub](https://github.com/letsbe10x/skill-hub).
2. `forge check --harness` passes.
3. README explains targets and intended audience.
4. No secrets, customer-specific rules, or licensed third-party text.
5. Link to relevant doc in `docs/` if introducing new patterns.

## Private presets

Do **not** open a PR here for customer-specific presets. Use
[public, private, and org-only extensions](public-private-org-extensions.md).
