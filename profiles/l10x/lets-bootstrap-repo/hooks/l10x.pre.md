# lets Pre-flight: lets-bootstrap-repo

## Status check

Run the status command and inspect whether service and engineering packs already exist before bootstrapping:

```bash
lets context status --repo-root . --format json
```

Present the pack table to the user and decide:
- All packs trusted AND engineering enriched → run `lets repo readiness` and exit.
- Service trusted but engineering not enriched → skip to enrichment offer.
- Service missing → proceed with bootstrap.
