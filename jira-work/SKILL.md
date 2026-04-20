---
name: jira-work
description: Query and manage Jira work items using the acli command line tool
---

# Jira Work

Use the Atlassian CLI (`acli`) to query and manage Jira work items.

## User Context

- The user is Adam Lawrence Sherwood (adam.lawrence.sherwood@dnb.no)
- Primary board: CC Platform Scrum board (board ID 91, project CCPLAT)

## Tool Reference

### Search work items assigned to user in active sprints

```sh
acli jira workitem search --jql "assignee = currentUser() AND sprint in openSprints()" --paginate
```

This finds all items across all boards. Use this by default.

### List active sprints for a board

```sh
acli jira board list-sprints --id <board-id> --state active
```

### List work items in a specific sprint

```sh
acli jira sprint list-workitems --board <board-id> --sprint <sprint-id> --paginate
```

### Search boards

```sh
acli jira board search --type scrum
acli jira board search --project <PROJECT_KEY>
```

### View a specific work item

```sh
acli jira workitem view <ISSUE-KEY>
```

### Search with custom JQL

```sh
acli jira workitem search --jql "<jql-query>" --paginate
```

Useful JQL fragments:
- `assignee = currentUser()` - items assigned to the user
- `sprint in openSprints()` - items in active sprints
- `status = "In Progress"` - filter by status
- `project = CCPLAT` - filter by project

### Transition a work item

```sh
acli jira workitem transition <ISSUE-KEY> --state "<status>"
```

### Output formats

Append `--json` for JSON or `--csv` for CSV output to any search or list command.

## Process

1. When the user asks about their work, default to searching across all boards with `currentUser()` and `openSprints()`
2. Group results by status (Done, In Progress, Ready for Deployment, SIT, To Do, etc.)
3. Present results in a concise table format
4. If the user asks about a specific board or sprint, use the board-specific commands
