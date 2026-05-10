# lets Pre-flight: lets-bootstrap-agents-md

## Context status check

Run the context status check before bootstrapping AGENTS.md:

```bash
lets context status --repo-root . --format json
```

Check `engineering.enriched`. If `true` and the user did not ask to update:
> "The engineering pack is already enriched. Run in update mode to refresh? (yes / exit)"

If exit: stop.
If yes or not yet enriched: proceed with the bootstrap.
