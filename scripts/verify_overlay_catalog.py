#!/usr/bin/env python3
"""Verify legacy overlay trees match profiles/lets/overlay-catalog.yml."""

from __future__ import annotations

import sys
from pathlib import Path

try:
    import yaml
except ImportError:
    print("PyYAML required: pip install pyyaml", file=sys.stderr)
    sys.exit(1)

ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / "profiles" / "lets" / "overlay-catalog.yml"
OVERLAY_ROOT = ROOT / "profiles" / "lets"


def main() -> int:
    catalog = yaml.safe_load(CATALOG.read_text(encoding="utf-8")) or {}
    listed = {entry["skill"] for entry in catalog.get("legacy_overlays") or [] if entry.get("skill")}

    found = {
        overlay.parent.name
        for overlay in sorted(OVERLAY_ROOT.glob("*/overlay.toml"))
        if overlay.parent.name != "presets"
    }

    errors: list[str] = []
    missing = sorted(found - listed)
    extra = sorted(listed - found)
    if missing:
        errors.append(f"overlay trees missing from catalog: {missing}")
    if extra:
        errors.append(f"catalog entries without overlay tree: {extra}")

    presets = catalog.get("presets") or {}
    for entry in catalog.get("legacy_overlays") or []:
        skill = entry.get("skill")
        target = entry.get("target_preset")
        if not skill or not target:
            continue
        preset_skills = set(presets.get(target, {}).get("skills") or [])
        if skill not in preset_skills:
            errors.append(f"{skill} maps to {target} but skill not in preset skills list")

    if errors:
        for err in errors:
            print(err, file=sys.stderr)
        return 1
    print(f"overlay-catalog OK ({len(found)} legacy trees)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
