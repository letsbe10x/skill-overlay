# Overlay migration (legacy → LAEM preset)

## Current state

### Shipped LAEM presets (3)

| Preset | Skills |
|--------|--------|
| `acme-sdlc-preset` | Example on `lets-develop-feature` |
| `lets-engineering-sdlc-preset` | Core SDLC engineering skills |
| `lets-research-studio-preset` | Research Studio skills |

### Legacy overlay trees (~19)

Per-skill directories under `profiles/lets/<skill-name>/`:

- `overlay.toml` — manifest (base skill, hook paths, anchors)
- `hooks/lets.pre.md`, `hooks/lets.post.md` — injected at sync time

These provide **hook-based** augmentation (context, governance, kit injection), not
LAEM section composition. See [kit injection](../profiles/lets/kit-injection.md).

## Why migrate

| Legacy overlay | LAEM preset |
|----------------|-------------|
| Hook injection only | Declarative compositions + lock file |
| Harder to audit stack | `artifact-layer-lock.json` + provenance |
| Per-skill maintenance | One preset targets many skills |
| Not in enterprise `harness_layers` | Enterprise-pin compatible |

## Migration paths

### Automatic (developer sync)

```bash
export LETS_HARNESS_AUTO_MIGRATE_OVERLAY=1
lets skill sync
```

Core helper: `migrate_overlay_toml` / `auto_migrate_overlay_profile`.

### Manual CLI

```bash
lets harness migrate-overlay --repo .
```

### Authoring a replacement preset

1. Identify hook behavior in `hooks/lets.pre.md` / `lets.post.md`.
2. Move durable rules into `compositions/*.md` with appropriate `strategy`.
3. Add preset under `profiles/lets/presets/<id>/`.
4. Deprecate overlay directory after validation.

## After migration

- Keep overlay directory only until all consumers migrated.
- Document preset id in team runbooks.
- Enterprise orgs: reference preset via `harness_layers` in skill set, not overlay paths.

## Tracking

Program status: [enterprise distribution (PRD-048)](enterprise-distribution-prd-048.md).

Original short notes: [profiles/lets/presets/MIGRATION.md](../profiles/lets/presets/MIGRATION.md).
