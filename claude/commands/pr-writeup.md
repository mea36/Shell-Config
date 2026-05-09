Given a commit range, produce a PR summary and QA steps.

## Usage
/pr-writeup <from-commit>[..<to-commit>]

If only one commit is provided, use that as the start and HEAD as the end.
If no argument is provided, diff against the main branch.

## Instructions

1. Run `git log --oneline <range>` to see the commits in scope.
2. Run `git diff <range>` to see the full diff.
3. Use that information to produce the following two sections:

---

### Summary

Write a concise PR description structured as three unlabelled paragraphs (omit any that don't apply):

1. **Why** — one sentence leading with what the PR does, followed by "so that [reason]". Example: "This adds X so that Y."
2. **What** — what the PR does or enables, from a product/feature perspective
3. **How** (optional) — how it works, if the mechanism is non-obvious or worth calling out

Guidelines:
- Do not use "Prior to this change", "Previously", or similar before/after framing
- Do not use "Why", "What", or "How" as headers or labels
- Do not summarise file-by-file diffs
- Stay high-level; avoid listing every file changed

If the diff alone doesn't fully capture the feature's intent (e.g. the range only covers refinements to a larger feature), look at the broader git history and surrounding code to understand what the feature as a whole enables. Write the summary from that perspective — what a user or developer needs to know about what this PR does, not just what lines changed.

### QA Steps

Write user-facing, product-level QA steps. These should describe what a person does in the product, not what HTTP requests to make. For example:
- "Configure your coding agent to connect to the Chromatic MCP server using your client_id"
- "Confirm you see a consent screen"
- "Deny the connection and confirm the agent receives an error"

All steps — including happy path and rejection/edge cases — should be numbered. Leave an empty line between each step. Wrap any commands in triple-backtick code fences.

Do not include a step for deploying the review app — that happens automatically.

The entire output (summary and QA steps) should be written in markdown. Output the raw markdown directly — do not wrap the entire output in a code block.
