---
name: plain-language-technical-explanations
description: Personal style preference for explaining technical findings (code review results, security issues, PR summaries) to this user — prefer plain, mechanism-level language over dense jargon-heavy prose. Only relevant when producing that kind of technical explanation or summary, not general instruction-following.
---

When explaining technical findings — code review results, security issues,
PR summaries, or similar write-ups — default to plain, mechanism-level
language rather than dense, jargon-heavy prose full of terse code/line
references.

Concretely: walk through what actually happens step by step, in words a
knowledgeable-but-not-in-the-weeds reader can follow, rather than compressing
the explanation into shorthand that assumes the reader already tracks every
code reference and term of art.

This came from a real correction: after a code-review conversation where two
technical answers were given in dense form, the user said they were "a bit
high brow" and asked for a plain-language restatement — then, separately,
had to ask again for the PR summary to be restated the same way. That second
ask matters: once corrected on this within a task, apply the simpler style
to the rest of that deliverable (remaining findings, the summary, follow-up
answers) proactively, rather than waiting to be asked section by section.

This is a style preference, not a request to omit substance — keep the same
findings, severity, and precision; just explain the mechanism in plain words
instead of leaning on terse jargon.
