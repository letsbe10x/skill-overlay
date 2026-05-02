# skill-overlay

letsbe10x augmentation profiles for [skill-hub](https://github.com/letsbe10x/skill-hub) skills.

Each overlay adds letsbe10x-specific pre-flight and post-run hooks around a base skill — context readiness checks, governance, pack enrichment, run tracking.

## Structure

```
profiles/
  l10x/
    <skill-name>/
      overlay.toml      # manifest: base skill, profile, hook anchors
      hooks/
        l10x.pre.md     # pre-flight steps (context, governance)
        l10x.post.md    # post-run steps (enrichment, sync)
scripts/
  compose-skill.sh      # render base + overlay into a final SKILL.md
```

## Compose a skill

```bash
# Render base skill + l10x overlay
./scripts/compose-skill.sh \
  --skill lets-develop-feature \
  --profile l10x \
  --output /tmp/rendered-skills

# Install the composed skill
l10x skill install /tmp/rendered-skills/lets-develop-feature
```

## Profiles

| Profile | Description |
|---|---|
| `l10x` | Full letsbe10x augmentation: context pre-flight, governance, pack enrichment |
