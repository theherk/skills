---
name: commit
description: Generate and create conventional commit messages with proper capitalization and formatting
---

# Conventional Commit Messages

## Format

Generate commit messages following Conventional Commits v1.0.0 with this capitalization:

```
type(scope): Capitalize the summary
```

The summary line must be imperative, present tense, and must not end with a period. The first word after the colon and space must be capitalized.

## Rules

- All lines must be a maximum of 72 characters long
- The summary line must always contain a scope
- If the current branch name contains a Jira ticket number matching `[a-zA-Z]{3,4}-[0-9]{3,}`, use the ticket as the scope
- Return only the commit message text with no code fences, commentary, or extra markup

## Body

Include a body only when there are many complex changes or changes requiring further explanation. Format the body as:

- A concise bullet list, each line starting with `-` and ending with a period
- Sentences should be imperative
- Only include meaningful, specific descriptions of the changes

Separate the summary from the body with a blank line.

## Examples

```
feat(auth): Add JWT token refresh mechanism
```

```
fix(PROJ-1234): Resolve null pointer in user lookup
```

```
refactor(api): Simplify error handling across endpoints

- Extract common error response builder into shared utility.
- Remove redundant try-catch blocks in individual handlers.
- Align error codes with updated API specification.
```

## Process

1. Check for a `.jj` directory; if present, use jujutsu commands, otherwise use git
2. Examine the staged changes (git) or current revision diff (jj) to understand what changed
3. Generate a commit message following the rules above
4. Create the commit using the generated message

## Important

Never push or update branches or bookmarks.
