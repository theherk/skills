---
name: commit
description: Generate and create commit messages with proper capitalization and formatting
---

# Commit Messages

## Format

Check the current branch name (git) or bookmarks on the current revision (jj) for a Jira ticket number matching `[a-zA-Z]{3,4}-[0-9]{3,}`.

### With Jira ticket

Use Conventional Commits v1.0.0 with the ticket as the scope:

```
type(PROJ-1234): Capitalize the summary
```

### Without Jira ticket

Use a clear, imperative commit message without conventional commit prefixes:

```
Capitalize the summary
```

## Rules

- The summary line must be imperative, present tense, and must not end with a period
- The first word of the summary must be capitalized
- All lines must be a maximum of 72 characters long
- Return only the commit message text with no code fences, commentary, or extra markup

## Body

Include a body only when there are many complex changes or changes requiring further explanation. Format the body as:

- A concise bullet list, each line starting with `-` and ending with a period
- Sentences should be imperative
- Only include meaningful, specific descriptions of the changes

Separate the summary from the body with a blank line.

## Examples

### With Jira ticket (branch: feature/PROJ-1234-auth-refresh)

```
feat(PROJ-1234): Add JWT token refresh mechanism
```

```
fix(PROJ-1234): Resolve null pointer in user lookup
```

### Without Jira ticket

```
Add JWT token refresh mechanism
```

```
Simplify error handling across endpoints

- Extract common error response builder into shared utility.
- Remove redundant try-catch blocks in individual handlers.
- Align error codes with updated API specification.
```

## Process

1. Check for a `.jj` directory; if present, use jujutsu commands, otherwise use git
2. Examine the staged changes (git) or current revision diff (jj) to understand what changed
3. Check the branch name (git) or bookmarks (jj) for a Jira ticket number
4. Generate a commit message following the rules above
5. Output the exact commit message you intend to use as a quoted block
6. Create the commit using the generated message
7. If using jujutsu, add a new revision to work on so we don't modify the same commit.

## Important

Never push or update branches or bookmarks.
