# lets Post-run: lets-review-code

## Release run lock after PR is raised

After the PR is created, release the workspace lock so subsequent pipeline runs can proceed:

```bash
lets run release $RUN_ID
```

If the goal exits with code 4 (workspace locked), release the lock first:

```bash
lets run list
lets run release $RUN_ID
```
