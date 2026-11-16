---
name: working-style-habits
description: Collected personal working-style corrections from past sessions, grouped by category — collaboration & trust (external context vs. the user's stated position, trusting deliberate user edits, not anchoring a new feature on a different existing one), implementation hygiene (post-pivot abstraction audit), scope discipline (not bundling unrequested fixes into requested work), testing philosophy (discarded-vs-shipped), code style (await-chaining), engineering review rigor (DB query scan-volume), and communication discipline (closing open questions). Relevant during iterative implementation, code review, or when a disk-change notice appears — not for simple one-shot tasks.
---

Working-style habits from real corrections in past sessions, grouped by
category. Each is independent — apply whichever is relevant to the moment,
not all at once.

## Collaboration & trust

How to weigh external information and the user's own actions against your
own assumptions.

**External context vs. the user's stated position.** When a fetched
external source (a Slack thread, a doc) conflicts with a design position the
user already stated, surface the conflict and confirm before replanning
around it — don't let it silently become the new source of truth. Came
from: fetching a Slack thread mid-design-discussion and reorienting the
whole plan around it without flagging the conflict — "it feels like you let
the slack thread override our previous conversation."

**Trust deliberate user edits.** When a disk-change reminder flags a file
changed outside your own edits and something expected is missing, don't
assume you broke it — check for a deliberate user edit before "restoring"
it. Came from: re-adding a comment the user had intentionally deleted,
twice — "the comment was removed bc i didn't want it."

**Don't anchor a new feature on a different existing one.** Two mechanisms
can share implementation plumbing (the same write path, the same status
checks) while answering genuinely different questions. Reason about a new
feature's design from its own requirements — don't cite an existing,
different feature's behavior as justification just because the code paths
overlap. Came from: repeatedly justifying an issue-rate design by pointing
at how a different, existing streak counter already worked — "can you stop
comparing to what stable streak does? stable streak is different."

## Implementation hygiene

**Post-pivot abstraction audit.** After a mid-task design pivot, re-check
every abstraction/helper introduced under the earlier approach for whether
it's still justified — don't leave cruft from the discarded approach just
because it still compiles. Came from: the same "why did you create X, is
that necessary?" correction happening three times in one session as one
abstraction was built on top of another that had already been superseded.

## Scope discipline

**Don't bundle unrequested fixes into requested work.** When doing scoped
work (e.g. "add tests for these two findings") and an unrelated issue turns
up along the way (a pre-existing type error, a bug in a file not part of
the ask), stop and ask before fixing it — even if the fix seems necessary,
such as for the build to pass. Don't fold it silently into the requested
change. Came from: fixing an unrelated pre-existing TypeScript error in a
model file while adding tests the user had asked for — "I told you not to
make the change to the test model."

## Testing philosophy

**Discarded approach ≠ bug.** An approach reconsidered and replaced
mid-iteration, before it was ever shipped or merged, isn't a "bug" — don't
propose a regression test for it. Regression tests protect behavior that
was actually live. Came from: framing a corrected pre-merge design as "the
bug you caught" — "this wasn't a bug, so i don't think it needs test."

## Code style

**Await-chaining.** Avoid `const x = (await fn()).prop` — await into a
plain variable, access the property at the point of use. Stated directly as
a dislike of inline await-then-dot-access chaining.

## Engineering review rigor

**DB query scan-volume on hot paths.** For a new query on a
frequently-invoked path, check what its cost actually scales with
(current-state size vs. an unbounded historical log), not just whether it's
indexed — an indexed query can still scale poorly if what it scans keeps
growing. Came from: "is the new query going to scale? the last query had
each field backed by an index. what about the new query?" — the new query
was indexed but scanned an app's entire unbounded quarantine history
instead of the current build's bounded scope.

## Communication discipline

**Close the loop on open questions.** Don't let a direct question go
unanswered when the conversation moves on to other work — come back and
explicitly close it once able to, rather than leaving it to be re-asked.
Came from: starting to answer a DB-round-trips question, getting pulled
into unrelated work, and having to be asked "did you answer my question
about trips to the db?"
