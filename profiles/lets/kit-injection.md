# Kit Content Injection (PRD-125)

## How Kit Rules Flow Into Skills

Kit behavioral content (Markdown rules from `packs/kits/<kit>/rules/*.md`) is injected
into skill execution at runtime via the overlay hook system.

### Injection Points

```
lets install engineering --with stack.python
                                     │
                                     ▼
                          ┌──────────────────────┐
                          │ Kit Resolver          │
                          │ (core/packs/)         │
                          │ - alias resolution    │
                          │ - conflict detection  │
                          │ - dependency pull-in  │
                          └──────────┬───────────┘
                                     │
                                     ▼
                          ┌──────────────────────┐
                          │ Kit Content Loader    │
                          │ (core/packs/          │
                          │  kit_content.py)      │
                          │ - reads rules/*.md    │
                          │ - parses frontmatter  │
                          │ - filters by phase    │
                          └──────────┬───────────┘
                                     │
                                     ▼
                          ┌──────────────────────┐
                          │ Overlay Pre-Hook      │
                          │ (skill-overlay)       │
                          │ - lets.pre.md injects │
                          │   composed rules at   │
                          │   "Kit Rules" anchor  │
                          └──────────────────────┘
```

### Runtime Flow (during skill execution)

1. User invokes a skill (e.g., `lets-develop-feature`).
2. Overlay pre-hook fires (`hooks/lets.pre.md`).
3. Pre-hook reads the bundle lockfile to discover enabled kits.
4. For each enabled kit in kit-compatibility.yaml that matches the current skill:
   - Load kit content via `lets kit rules --on <bundle> --phase <current_phase> --json`
   - Inject the composed rules text into the agent's context
5. Agent executes with kit rules as active behavioral constraints.

### Injection Format

Kit rules appear in the agent's context as:

```markdown
# Active Kit Rules

> Sources: stack.python:coding, stack.python:testing, domain.healthcare:hipaa

---

[composed rules content here]

---
```

### Phase Mapping

| Skill | Phase |
|-------|-------|
| lets-develop-feature | implementation |
| lets-review-code | review |
| lets-verify-change | verify |
| lets-create-plan | implementation |

### Degradation

If `lets kit rules` is unavailable (CLI not installed, no kits enabled):
- Overlay falls back to bundle-level rules only (`bundle-rules/engineering.yaml`)
- No error surfaced — kit injection is additive enhancement
