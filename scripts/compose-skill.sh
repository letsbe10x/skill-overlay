#!/usr/bin/env bash
# compose-skill.sh — render a final SKILL.md from skill-hub base + lets overlay
# Usage: ./scripts/compose-skill.sh --skill <name> --profile lets --output /tmp/rendered
set -euo pipefail

SKILL=""
PROFILE="l10x"
OUTPUT_DIR=""
SKILL_HUB_DIR=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --skill) SKILL="$2"; shift 2 ;;
    --profile) PROFILE="$2"; shift 2 ;;
    --output) OUTPUT_DIR="$2"; shift 2 ;;
    --hub-dir) SKILL_HUB_DIR="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

[[ -z "$SKILL" ]] && { echo "error: --skill required"; exit 1; }
[[ -z "$OUTPUT_DIR" ]] && { echo "error: --output required"; exit 1; }

OVERLAY_DIR="$(dirname "$0")/../profiles/${PROFILE}/${SKILL}"
[[ ! -d "$OVERLAY_DIR" ]] && { echo "error: no overlay found for profile=${PROFILE} skill=${SKILL}"; exit 1; }

# Resolve base skill
if [[ -n "$SKILL_HUB_DIR" ]]; then
  BASE_SKILL="${SKILL_HUB_DIR}/${SKILL}/SKILL.md"
else
  # fetch from GitHub
  BASE_SKILL="/tmp/skill-hub-${SKILL}-SKILL.md"
  curl -fsSL "https://raw.githubusercontent.com/letsbe10x/skill-hub/main/${SKILL}/SKILL.md" -o "$BASE_SKILL"
fi

[[ ! -f "$BASE_SKILL" ]] && { echo "error: base skill not found at ${BASE_SKILL}"; exit 1; }

PRE_HOOK="${OVERLAY_DIR}/hooks/l10x.pre.md"
POST_HOOK="${OVERLAY_DIR}/hooks/l10x.post.md"

mkdir -p "${OUTPUT_DIR}/${SKILL}"
OUT="${OUTPUT_DIR}/${SKILL}/SKILL.md"

# Compose: frontmatter preserved, pre injected after Overview, post appended
python3 - <<'PYEOF' "$BASE_SKILL" "$PRE_HOOK" "$POST_HOOK" "$OUT"
import sys, re
base_path, pre_path, post_path, out_path = sys.argv[1:]

base = open(base_path).read()
pre  = open(pre_path).read().strip() if open(pre_path).read().strip() and not open(pre_path).read().strip().startswith("# No pre-hook") else ""
post = open(post_path).read().strip() if open(post_path).read().strip() and not open(post_path).read().strip().startswith("# No post-hook") else ""

result = base

# Inject pre after first ## heading (after frontmatter + note)
if pre:
    match = re.search(r'\n## ', result)
    if match:
        insert_at = match.start()
        result = result[:insert_at] + "\n\n## letsbe10x Pre-flight\n\n" + pre + result[insert_at:]

# Append post at end
if post:
    result = result.rstrip() + "\n\n## letsbe10x Post-run\n\n" + post + "\n"

with open(out_path, "w") as f:
    f.write(result)
print(f"composed → {out_path}")
PYEOF
