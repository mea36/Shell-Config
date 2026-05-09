---
allowed-tools: Bash(git diff*), Bash(git log*), Bash(git status*), Bash(gh pr diff*), Bash(gh pr view*), Bash(gh pr list*)
---

# Elixir Code Review

Review the changes on the current branch against main. If a PR number is provided as an argument, review that PR's diff instead.

## Steps

1. Get the diff:
   - If a PR number was provided, run `gh pr diff <number>` and `gh pr view <number>` for the description
   - Otherwise, run `git diff main...HEAD --stat` then `git diff main...HEAD`
   - Also check `git status` for uncommitted changes and read those files directly

2. Read any new files in full — they won't appear completely in the diff

3. Before commenting on conventions, check sibling files of the same type to understand what this project actually does rather than assuming defaults

## What to Review

- Security issues
- Bugs and correctness
- Bad style
- Anything that goes against Elixir best practices
- Test coverage
- Documentation

## Output Format

- **Summary** — what the change does in 2-3 sentences
- **Security** — issues or confirmation it looks clean
- **Bugs / Correctness** — anything that would cause failures or unexpected behavior
- **Style / Minor** — small improvements
- **What's Good** — non-obvious correct decisions worth calling out
