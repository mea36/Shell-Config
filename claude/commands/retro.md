---
name: retro
description: Review the current conversation for learnings about how the user prefers code structured or how they like to work, then save each as a memory or a skill. Only invoke this when the user explicitly types /retro — do not self-invoke based on inferred intent, even if a correction or preference just occurred.
---

Review this entire conversation (not just the last few messages) for feedback-worthy
learnings: corrections, confirmed preferences, or working-style habits — code
structure/style (naming, comments, abstraction, file organization), process, tool
usage, communication. Same shape of thing the auto-memory system's `feedback` type
already captures passively — this is a deliberate, systematic pass over the same
territory, not a new category.

## 1. Gather candidates

Pull out every distinct learning. For each, note the rule, the *why* (what the user
said or the incident that prompted it), and *how to apply* it.

## 2. Dedupe before presenting anything

For each candidate, check:
- Existing files in this project's memory directory (`type: feedback` entries).
- This project's `CLAUDE.md`.

Drop anything already covered verbatim. If a candidate refines, narrows, or
contradicts something existing, keep it — it goes through the conflict path below
instead of being silently dropped or silently overwritten.

## 3. Walk through survivors one at a time

For each remaining candidate, propose a classification and ask the user to
confirm or override before moving to the next:

**Shape:**
- Passive preference (applies generally, no clear invocation trigger) → memory.
- Concrete, triggerable procedure ("when doing X, do Y") → a skill.

**Scope:**
- Repo-specific → this project's memory directory, or this repo's `.claude/skills/`.
- Personal and universal (would apply in any repo, not just this one) → ask
  whether to promote it into a global personal skill under
  `/Users/chromadactyl/source/Shell-Config/claude/commands/` (flat `.md`, frontmatter
  `name` + `description` only, no `disable-model-invocation` — that field isn't
  supported by this convention, so write a narrow, self-restricting description
  instead) versus leaving it as project memory.
- Team-wide convention (not just Mel's preference) → ask whether to write it into
  this project's `CLAUDE.md`, or a project skill under `.claude/skills/<name>/SKILL.md`.

**Conflicts:** if a candidate refines or contradicts an existing memory/skill, show
the old and new versions side by side and let the user choose: overwrite, merge,
keep both, or skip. Never auto-overwrite.

Only write a file once the user has confirmed its destination.

## 4. Summarize

End with a short summary: how many learnings were saved as memory, how many became
or updated a skill (and where), and how many were skipped as duplicates. No
narration beyond that — the memory/skill files themselves are the record.
