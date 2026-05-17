# lets Post-run: lets-research-content-evaluate

## Persona simulation pass (optional)

After ingesting the artifact, optionally run persona simulation to get segment friction and trust signals:

```bash
lets persona simulate --repo-root . \
  --persona-id skeptical_buyer --scenario-id trust_and_click \
  --packs-root "$PACKS_ROOT" \
  --kind raw_copy --text "..." \
  --use-llm
```

Segment-aware simulation results complement the rubric-based critique.
