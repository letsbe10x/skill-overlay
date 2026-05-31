# Use cases

Concrete scenarios mapping goals to **public preset**, **private preset**, or
**enterprise skill set**.

## UC-1 — Open-source engineering defaults

**Goal:** All letsbe10x users get the same SDLC append rules on core engineering skills.

| Item | Choice |
|------|--------|
| Channel | Public preset in `skill-overlay` |
| Artifact | `lets-engineering-sdlc-preset` |
| Install | `lets harness add` or bundle sync |
| Enforcement | Voluntary |

## UC-2 — Research Studio consistency

**Goal:** Research skills share methodology append blocks.

| Item | Choice |
|------|--------|
| Channel | `lets-research-studio-preset` (public) |
| Targets | `lets-research-*` skills per manifest `requires.targets` |

## UC-3 — Customer compliance overlay (confidential)

**Goal:** Acme Corp requires extra compliance text on `lets-develop-feature`; text is not public.

| Item | Choice |
|------|--------|
| Channel | **Private** git repo `acme/lets-presets` |
| Format | LAEM preset manifest (same as public) |
| Install | `lets harness add ~/acme-presets/compliance-preset` |
| Do not | Commit to `skill-overlay` |

## UC-4 — HQ-mandated skill set for all developers

**Goal:** Every machine must run approved skill versions; auditors see fleet posture.

| Item | Choice |
|------|--------|
| Channel | **Enterprise** control-plane skill set |
| Flow | preview → approve → enforce → `lets enterprise sync` |
| Harness | Include `harness_layers[]` for LAEM stack pins |
| Audit | Fleet CSV, run `harness_snapshot`, enterprise status CLI |

## UC-5 — Preview a policy change before rollout

**Goal:** Security reviews diff between v1 and v2 skill sets.

| Item | Choice |
|------|--------|
| CP | Create preview v2; diff against enforced v1 in admin UI |
| CLI | `lets enterprise diff --left-id <v1> --against-id <v2>` |
| Local | `lets enterprise diff --file proposed.json` before apply |

## UC-6 — Air-gapped or CI apply

**Goal:** No live CP in CI; apply pinned JSON from artifact storage.

| Item | Choice |
|------|--------|
| Channel | Export enforced JSON via `lets enterprise pull --out` |
| Apply | `lets enterprise apply --file enforced.json` |
| Verify | `lets harness verify` in CI |

## UC-7 — Repo experiment (discardable)

**Goal:** Try a preset change without affecting org.

| Item | Choice |
|------|--------|
| Channel | `override` role under `.letsbe10x/overrides/` or local `harness add` |
| Cleanup | `lets harness remove <id>` |

## UC-8 — Migrate legacy overlay hooks

**Goal:** Retire `overlay.toml` for a skill in favor of LAEM preset.

| Item | Choice |
|------|--------|
| Tool | `lets harness migrate-overlay` or `LETS_HARNESS_AUTO_MIGRATE_OVERLAY=1` on sync |
| Doc | [overlay migration](overlay-migration.md) |

## UC-9 — Investigate fleet harness drift

**Goal:** See which repos report harness snapshots and drift status.

| Item | Choice |
|------|--------|
| UI | Control-plane Fleet → Harness layers panel |
| Export | `harness-fleet.csv` |
| Repair hint | `lets harness repair` per repo |

## UC-10 — Break-glass during incident

**Goal:** Temporarily disable one enforced enterprise artifact locally.

| Item | Choice |
|------|--------|
| Command | `lets enterprise break-glass disable skill:foo:1.0.0` |
| Audit | Visible in `lets enterprise status` recent break-glass events |
| Note | Does not change HQ enforced config — local posture only |
