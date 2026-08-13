Review a Chromatic Public API Change Proposal from Notion against the public API guidelines.

## Usage
/review-public-api-proposal <notion-url>

## Instructions

1. Fetch the Notion page at the URL in `$ARGUMENTS` using the Notion MCP tool.

2. Read both guideline documents:
   - `docs/ref/guidelines/public-api.md`
   - `docs/ref/style-guides/graphql-descriptions.md`

3. Extract the proposed GraphQL schema changes from the Notion page.

4. Review the changes against the guidelines. For each potential issue, **check the existing codebase** (`services/index/api-public/`) to verify it's a real violation and not an established pattern before flagging it. Retract any finding that turns out to be consistent with how existing types are written.

5. If any change appears to be a breaking change (removing a field, renaming, changing nullability, adding a required argument, etc.), note it — even if the proposal is classified otherwise.

6. Output findings in two sections:

   **Issues** — violations of the guidelines, each with a citation to the specific rule and a concrete suggestion for how to fix it.

   **Looks Good** — things that were checked and passed, to show the review was thorough.
