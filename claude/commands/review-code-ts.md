---
allowed-tools: Bash(gh pr diff*), Bash(gh pr view*), Bash(gh pr list*), Bash(git diff*), Bash(git log*), Bash(git status*), Bash(npx eslint*), Bash(npm run lint*), Bash(yarn lint*), Bash(pnpm lint*), Read(package.json)
---

Pre-review a PR before requesting teammate review. If a PR number or URL is provided as an argument, review that PR; otherwise use the current branch's PR.

## Steps

1. Get the PR context:
   - `gh pr view <number>` — read the title, description, and linked ticket
   - `gh pr diff <number>` — get the full diff
   - Read any new files in full — they won't appear completely in the diff

2. Lint the changed files:
   - Get the list of changed `.ts`/`.tsx` files: `git diff --name-only origin/main...HEAD | grep -E '\.(ts|tsx)$'`
   - Check `package.json` to find the lint script (prefer `npm run lint -- <files>` if it accepts file args, otherwise fall back to `npx eslint <files>`)
   - Run the linter on the changed files and capture output — lint errors are blocking findings, warnings are nits
   - If the lint script doesn't support per-file args, run `npx eslint <files>` directly

3. If the diff touches the public API (e.g. files under `api-public/`, `lib/schema/`, or GraphQL types exposed publicly), invoke the `review-public-api-proposal` skill and read the guidelines before continuing

4. Before reviewing conventions, check sibling files to understand what this codebase actually does rather than assuming defaults

## What to Review

### Security
- Injection: unsanitized input in queries, shell commands, or templates
- Hardcoded secrets, API keys, or tokens
- Missing authorization checks on new endpoints or resolvers
- Insecure deserialization, path traversal, IDOR
- Sensitive data (PII, tokens) appearing in logs, error messages, or responses

### Bugs & Correctness
- Logic errors and off-by-one mistakes
- Unhandled error paths and edge cases
- Null/undefined dereferences
- Race conditions or async bugs
- Behavior that contradicts the PR description or linked ticket

### Code Consistency & Style
- Naming conventions match the surrounding codebase
- Dead code, unused imports, or leftover debug statements
- Duplication that could use existing utilities
- New code follows patterns established in the files it touches
- Spaghetti code: deeply nested conditionals/callbacks, functions doing too many unrelated things, tangled control flow that could be flattened or split into named steps
- Comments that narrate history or a diff ("this used to do X, now it does Y", "changed from...", "previously...") instead of describing the current state — flag these regardless of whether the surrounding code is otherwise fine
- Comments that restate what the code already says plainly, rather than explaining a non-obvious why

### Test Coverage
- Each new function, branch, or behavior has a test
- Edge cases and error paths are exercised
- If the project has a testing guide (e.g. `docs/testing/index-testing.md`), tests are in the right category (unit vs. integration)

## Output Format

- **Summary** — what the change does in 2-3 sentences
- **Lint** — errors and warnings from ESLint, or confirmation it's clean
- **Security** — findings or confirmation it looks clean
- **Bugs / Correctness** — anything that would cause failures or unexpected behavior
- **Consistency & Style** — naming, patterns, duplication
- **Test Coverage** — gaps or confirmation coverage is adequate
- **Ready to share?** — yes/no, and what must be addressed first if no

For each finding include the severity (Critical / High / Medium / Low / Nit), a `file:line` reference, and a suggested fix.
