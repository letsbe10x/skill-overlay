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
# Render base skill + lets overlay
./scripts/compose-skill.sh \
  --skill lets-develop-feature \
  --profile lets \
  --output /tmp/rendered-skills

# Install the composed skill
lets skill install /tmp/rendered-skills/lets-develop-feature
```

## Automated sync

`lets skill sync` fetches base skills from skill-hub and composes them with the
matching overlay automatically. The manual `compose-skill.sh` script is deprecated
in favour of the sync command (see ADR decision-024 in ground-truth).

## Profiles

| Profile | Description |
|---|---|
| `l10x` | Full letsbe10x augmentation: context pre-flight, governance, pack enrichment |

## Contributing

### Adding an overlay for a new skill

1. Ensure the base skill exists in
   [skill-hub](https://github.com/letsbe10x/skill-hub). Overlays without a
   matching base are orphaned and will be ignored by `lets skill sync`.
2. Create `profiles/l10x/<skill-name>/overlay.toml`:
   ```toml
   [overlay]
   schema_version = "1"
   profile = "l10x"
   base_skill = "<skill-name>"
   base_repo = "https://github.com/letsbe10x/skill-hub"

   [hooks]
   pre = "hooks/l10x.pre.md"
   post = "hooks/l10x.post.md"

   [anchors]
   pre_after = "## Overview"
   post_before = "## Outputs"

   [meta]
   description = "letsbe10x runtime augmentation"
   maintainer = "letsbe10x"
   ```
3. Write hook files in `profiles/l10x/<skill-name>/hooks/`:
   - `l10x.pre.md` — context pre-flight, governance checks, run directory loading
   - `l10x.post.md` — enrichment, sync, pack updates
4. Test composition: `lets skill sync --skill <name>` and verify the output.
5. Open a PR.

### Anchor placement

- `pre_after` — the pre-hook is injected immediately after this heading in the base
- `post_before` — the post-hook is injected immediately before this heading

If an anchor heading is not found in the base skill, fallback placement is used
(pre: before first `##` heading; post: appended at end).

### Rules

- Hooks must only add `l10x`-specific behaviour (governance, context, packs).
- Never duplicate base skill content in a hook.
- Every overlay must have a matching base in skill-hub — orphaned overlays are a bug.
