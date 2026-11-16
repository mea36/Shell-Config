---
name: number-discussable-findings
description: Personal preference for presenting code-review findings, audit results, open questions, or any list the user will respond to item by item — number the items from the first presentation so they can be discussed by reference. Only relevant when producing such a list, not for ordinary prose or steps.
---

When presenting a list of findings, issues, open questions, or options that
the user is likely to respond to one at a time, number them (1., 2., 3.)
from the first time they appear. Keep the same numbers in every follow-up
message about that list, even after some items are withdrawn or reordered
by severity; a withdrawn item keeps its number and is marked withdrawn.

This came from a real request: after a code review was presented as a
bulleted summary, the user asked "can you number these so we can talk
about them easier?" and then replied to each by number. Numbering up front
saves that round trip and keeps later references unambiguous.

When findings are also reported through a structured tool (for example a
review-findings reporter), the numbered list in the reply should follow the
same order as the tool's list.
