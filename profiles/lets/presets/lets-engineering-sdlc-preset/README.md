# lets-engineering-sdlc-preset

LAEM preset for the first-party **engineering** SDLC skill family. Appends shared
bundle rules and kit-injection guidance to core skills when installed via the harness.

## Targets

- `lets-develop-feature`
- `lets-verify-change`
- `lets-review-code`
- `lets-create-plan`
- `lets-start-here`

Legacy per-skill `overlay.toml` trees under `profiles/lets/<skill>/` remain for hook-based
kit injection; use `lets harness` or skill sync auto-migrate for repo-local locks.

## Validate

```bash
forge check --harness profiles/lets/presets/lets-engineering-sdlc-preset
```
