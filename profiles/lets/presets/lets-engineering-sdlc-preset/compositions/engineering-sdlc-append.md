## Engineering SDLC preset (lets profile)

Applies first-party engineering bundle expectations when the LAEM lock is in use.
Legacy `overlay.toml` hooks under `profiles/lets/<skill>/` remain supported via
auto-migrate until each profile has a checked-in preset.

### Bundle rules (engineering)

- Mutation policy: additive only; require evidence and tests before merge.
- Governance classification required; breaking changes need explicit approval.
- See `profiles/lets/bundle-rules/engineering.yaml` for the full rule set.

### Kit injection

When kits are enabled on the engineering bundle, pre-hooks load phase-matched kit
rules per `profiles/lets/kit-injection.md` and `kit-compatibility.yaml`.

### Verification

- Run `lets harness verify --policy` before merging harness lock changes.
- Use `forge check --harness` on preset manifests before publishing.
