# lets Post-run: lets-bootstrap-repo

## Readiness report

After bootstrap completes, run the readiness report to confirm the repo is AI-ready:

```bash
lets repo readiness --repo-root . --format json
```

Present:
- Readiness level and score (e.g. "L2, score 72 of 100")
- Per-pillar status
- Top 3 gaps with exact remediation commands
- Next suggested command

Done when the repo readiness output has been shown to the user and any blocking bootstrap error has been surfaced explicitly.
