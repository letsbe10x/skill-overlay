# lets Pre-flight: lets-start-here

## Context readiness check

Run the context status check to determine repo readiness before classifying intent:

```bash
lets context status --format json
```

If `readiness_score < 50`, print:
```
⚠  Context readiness score is below 50/100 — context is insufficient for reliable routing.
   Run `lets context bootstrap` to set up service context before proceeding.
```

Ask the user whether to continue anyway or stop to bootstrap first. If `readiness_score >= 50`, continue to classification.

## Classify intent

Run the classification command:

```bash
lets classify --request "..." --format json
```

If classification fails, treat as `route_family: delivery`, `governance_verdict: WARN`, `confidence: 0.49`, `degraded: true`.

## Fetch install suggestions

```bash
lets suggest --request "..." --format json --top 3
```

Present the top 3 install suggestions with rationale and governance impact after routing summary.
