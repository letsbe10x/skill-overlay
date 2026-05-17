# lets Pre-flight: lets-develop-feature

## Bind repo-local run state (`.lets/`) and runtime context (if present)

Before running `lets-develop-feature`, bind to the repo-local run artifacts under `.lets/` so the workflow is resumable and auditable in the current project.

```bash
# Prefer repo-local develop-feature run state (recommended):
cat .lets/runs/lets-develop-feature/latest 2>/dev/null || true
ls -la .lets/runs/lets-develop-feature/ 2>/dev/null || true

# If the `lets` CLI is available, this is the easiest status check:
lets skill run status lets-develop-feature --format json 2>/dev/null || true
```

If a `.lets` run is present:

1. Read `.lets/runs/lets-develop-feature/<run_id>/service-context.md` and extract:
   - non-negotiables (bind the run)
   - critical paths touched (extra verification obligation)
2. Read `.lets/runs/lets-develop-feature/<run_id>/execution-packet.md`:
   - treat it as the contract for file scope + per-package verification commands
3. Ensure the run’s `run-state.json` accounts for all 9 stages (no stage implicit).

If a `.lets` run is NOT present and the `lets` CLI is available, initialize one:

```bash
lets skill run init lets-develop-feature <slug>
```

Additionally (letsbe10x runtime):

```bash
# If an engine-managed run is active, still honor its governance verdict:
lets run list --format json | jq '.[0].run_dir // empty' 2>/dev/null || true
```

If an engine `run_dir` is found:
1. Read `workflow_context.json` from the resolved run directory — extract `must_preserve.non_negotiables`, `must_preserve.critical_paths`, and `defaults.governance_posture`.
2. Read `classification.json` from the same run directory — extract `route_family`, `governance_verdict`, and `selected_goal_sequence`.
3. If `governance_verdict == "BLOCK"`: stop immediately, display the block reason, and do not proceed.

If neither `.lets` run state nor an engine `run_dir` is present, proceed without pre-flight silently.
