# Overlay → LAEM preset migration

> **Full guide:** [docs/overlay-migration.md](../../../docs/overlay-migration.md) and
> [docs/README.md](../../../docs/README.md).

## Shipped presets

| Preset | Skills |
|--------|--------|
| `acme-sdlc-preset` | Example / compliance (`lets-develop-feature`) |
| `lets-engineering-sdlc-preset` | Core SDLC engineering skills |
| `lets-research-studio-preset` | Research Studio skills |

## Remaining legacy trees

Per-skill directories under `profiles/lets/<skill>/overlay.toml` still provide
**hook-based** kit injection (see `kit-injection.md`). Repo-local migration uses:

- `lets harness` / skill sync auto-migrate (`LETS_HARNESS_AUTO_MIGRATE_OVERLAY`)
- `core` helper `migrate_overlay_toml` for one-off conversion

## Authoring checklist

1. Add or update preset under `profiles/lets/presets/<id>/`.
2. Run `forge check --harness` on the preset directory.
3. Recompute `distribution.content_hash` with `letsbe10x.harness.hashutil.sha256_prefixed`.
4. Reference preset ID from enterprise `harness_layers` or `lets harness add`.
