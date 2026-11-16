---
name: implement
description: Start implementing a Linear ticket or task description — find its saved plan, set up a worktree, and grill the user if no plan exists
disable-model-invocation: true
argument-hint: <linear-issue-id | task description>
---

Implement: $ARGUMENTS

## 1. Understand the task

- If `$ARGUMENTS` is a Linear issue ID or URL (e.g. `API-849`), use the Linear tools `get_issue` and `list_comments` to read the title, description, and comments.
- Otherwise treat `$ARGUMENTS` as a free-text task description.

## 2. Look for a saved plan

Search both locations, matching on the ticket ID (case-insensitive) and on keywords from the title/description:

- Memory: `~/.claude/projects/-Users-chromadactyl-chromaui-chromatic/memory/` (start from `MEMORY.md`; memory files often point to a plan file)
- Plan files: `/Users/chromadactyl/chromaui/chromatic/.claude/*.md`

Then confirm with the user using `AskUserQuestion`:

- **Plan found:** name the file(s) and give a 2–3 line summary of the plan. Ask whether it's the right plan. If they say no, ask which plan to use or treat it as no plan.
- **No plan found:** say which locations you searched and confirm there is no plan before continuing.

## 3. Create a worktree

- Slug: lowercase ticket ID + kebab-cased title (e.g. `api-849-time-series-query-for-quarantines`); for a description, a short kebab-cased summary.
- If `~/chromaui/worktrees/<slug>` already exists, ask whether to reuse it.
- Otherwise, from `/Users/chromadactyl/chromaui/chromatic`:

  ```bash
  git fetch origin main
  git worktree add ~/chromaui/worktrees/<slug> -b mel/<slug> origin/main
  ```

## 4. Install dependencies

```bash
cd ~/chromaui/worktrees/<slug> && yarn install
```

Run it in the background so step 5 can proceed meanwhile. Report failures with the output.

## 5. Get to an agreed plan

- **No plan:** invoke the `grill-me` skill with the task context. Once the grilling reaches shared understanding, save the resulting plan to `/Users/chromadactyl/chromaui/chromatic/.claude/<slug>-plan.md` and add a memory pointing to it.
- **Plan confirmed:** continue to step 6.

## 6. Implement

Work only inside the worktree, following the plan. Run relevant tests (`yarn test-backend <file>` / `yarn test-webapp <file>`), `yarn lint`, and `yarn typescript:check`. Leave changes uncommitted and unstaged for the user to review.
