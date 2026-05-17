# lets Post-run: lets-bootstrap-agents-md

## Engineering pack enrichment

After all AGENTS.md files pass verification, enrich the engineering context pack:

```bash
REPO_NAME="$(basename "$(pwd)")"
lets context enrich \
  --pack engineering \
  --enrichment-file "/tmp/${REPO_NAME}/.agents-bootstrap/enrichment.json" \
  --repo-root .
```

Confirm to user: "Engineering pack enriched. `repo_summary` and `key_flows` are now populated. Run `lets context status` to verify enriched = true."

If `lets context enrich` fails (e.g. engineering pack not yet verified), show the error and tell the user to run `lets run exec onboard-repo` first.
