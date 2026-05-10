# lets Post-run: lets-research-competitive-scan

## Persona simulation pass (optional)

After ingesting competitor artifacts, optionally run the same cohort scenario across all competitors for segment-aware friction and trust signals:

```bash
lets persona simulate --repo-root . \
  --cohort-id baseline --scenario-id trust_and_click \
  --packs-root "$PACKS_ROOT" \
  --kind url --uri "https://competitor.example.com" \
  --cohort-size 24 --seed 42 --sampling-mode quota \
  --use-llm
```

Use the same cohort + scenario for all competitors to maintain comparability.
