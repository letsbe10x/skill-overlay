# Operator command reference

Commands run from a **developer repo** with `lets` CLI installed (`core` package).
Replace paths and org IDs for your environment.

## Harness (repo-local LAEM)

| Command | Purpose |
|---------|---------|
| `lets harness init` | Create lock file + override dirs |
| `lets harness add <path>` | Install preset/extension from directory |
| `lets harness remove <id>` | Remove layer and re-compose |
| `lets harness list` | Show layers per target |
| `lets harness list --json` | Machine-readable layers |
| `lets harness resolve skill:<name> --base <SKILL.md>` | Preview composed section |
| `lets harness status` | Drift + policy summary |
| `lets harness lock` | Print lock file path and summary |
| `lets harness verify` | Validate lock integrity |
| `lets harness verify --policy` | Verify + lock-in-git policy (§14) |
| `lets harness repair --repo .` | Reconcile drift where supported |
| `lets harness migrate-overlay` | Convert legacy `overlay.toml` → preset |
| `lets harness sign-bundle <bundle.json>` | Sign enterprise harness layers |

### Install public preset from this repo

```bash
git clone https://github.com/letsbe10x/skill-overlay
lets harness init
lets harness add ./skill-overlay/profiles/lets/presets/lets-engineering-sdlc-preset
lets harness list
lets skill sync
```

## Skill sync (base + overlay / harness)

| Command | Purpose |
|---------|---------|
| `lets skill sync` | Fetch skill-hub bases + apply overlays/harness |
| `lets skill sync --skill <name>` | Single skill |
| `lets skill sync --bundle engineering` | Bundle-first onboarding |

Auto-migrate: set `LETS_HARNESS_AUTO_MIGRATE_OVERLAY=1` to convert legacy overlay profiles during sync.

## Enterprise (org distribution)

Configure before sync:

```bash
export LETSBE10X_CONTROL_PLANE_URL=https://your-cp.example
# credentials: ~/.letsbe10x/credentials.json  {"org":"<org-uuid>","token":"..."}
```

| Command | Purpose |
|---------|---------|
| `lets enterprise status` | Local config, trust, harness lock, break-glass |
| `lets enterprise status --repo . --format text` | Human-readable |
| `lets enterprise status --run-id <id>` | Include run enterprise evidence |
| `lets enterprise pull` | Fetch enforced config (no install) |
| `lets enterprise pull --out enforced.json` | Save to file |
| `lets enterprise pull --write-local` | Persist config without apply |
| `lets enterprise sync` | Fetch enforced + apply |
| `lets enterprise sync --auto-trust-publishers` | Approve publishers during apply |
| `lets enterprise sync --include-optional` | Apply optional artifacts too |
| `lets enterprise apply --file <json>` | Apply from file (air-gapped) |
| `lets enterprise diff --file <candidate.json>` | Diff vs local stored config |
| `lets enterprise diff --file A --against-file B` | Diff two files |
| `lets enterprise diff --left-id <uuid> --against-id <uuid>` | Diff CP versions |
| `lets enterprise trust list` | Trusted publishers |
| `lets enterprise trust approve <publisher>` | Un-quarantine publisher |
| `lets enterprise break-glass disable <artifact_id>` | Disable enforced artifact (audited) |
| `lets enterprise break-glass enable <artifact_id>` | Re-enable |

## Install policy

```bash
lets install-policy show --artifact-kind skill
```

## Quality gates (authors)

```bash
forge check --harness ./profiles/lets/presets/my-preset
```

## Smoke / acceptance (maintainers)

```bash
# From core repo — requires sibling control-plane
cd core && bash scripts/verify-enterprise-lifecycle-smoke.sh
cd core && bash scripts/verify-laem-acceptance.sh
```

## Control-plane (operators)

| API / UI | Purpose |
|----------|---------|
| Admin org → Enterprise skill set panel | Versions, diff, lifecycle buttons |
| `POST .../enterprise/skill-set` | Create preview |
| `POST .../{id}/approve` | Approve |
| `POST .../{id}/enforce` | Enforce |
| `POST .../{id}/rollback` | Roll back to prior enforced |
| `GET .../{id}/diff?against=<id>` | Version diff |
| `GET /api/exports/harness-fleet.csv` | Fleet harness export |
| `GET /api/exports/fleet.csv` | Fleet + harness columns |
