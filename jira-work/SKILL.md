---
name: jira-work
description: Query and manage Jira work items using the acli command line tool
---

# Jira Work

Use the Atlassian CLI (`acli`) to query and manage Jira work items.

## User Context

- The user is Adam Lawrence Sherwood (adam.lawrence.sherwood@dnb.no)
- Primary board: CC Platform Scrum board (board ID 91, project CCPLAT)

## CCPLAT Workflow Statuses

The CCPLAT board uses the following statuses (in rough workflow order):

1. To Do
2. In Progress
3. Blocked/Waiting
4. Dev
5. Ready for Deployment ← this means "ready for production" (RFC awaiting approval)
6. Ready for UAT
7. UAT
8. Prod
9. Done
10. Reject
11. Cancelled

**Important:** Not all transitions are direct. Some statuses require stepping through intermediate states. For example, transitioning from "In Progress" to "Prod" requires going through "Ready for Deployment" first. When the user says "ready for prod", use "Ready for Deployment".

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
acli jira workitem view <ISSUE-KEY> --json
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
acli jira workitem transition --key "<ISSUE-KEY>" --status "<status>" --yes
```

Multiple keys can be comma-separated:

```sh
acli jira workitem transition --key "KEY-1,KEY-2" --status "Done" --yes
```

**Note:** If a transition fails with "No allowed transitions found", you need to step through intermediate statuses. For example, "In Progress" -> "Ready for Deployment" -> "Prod".

### Add a comment

```sh
acli jira workitem comment create --key "<ISSUE-KEY>" --body "Comment text"
```

### Create a link between work items

```sh
acli jira workitem link create --out <BLOCKER-KEY> --in <BLOCKED-KEY> --type <link-type> --yes
```

Available link types include: Blocks, Cloners, Contains, Depends, Duplicate, Relates, and others.

Example (A blocks B):
```sh
acli jira workitem link create --out CCPLAT-100 --in CCPLAT-200 --type Blocks --yes
```

### List links on a work item

```sh
acli jira workitem link list --key <ISSUE-KEY>
```

### List available link types

```sh
acli jira workitem link type
```

### Output formats

Append `--json` for JSON or `--csv` for CSV output to any search or list command.

## Process

1. When the user asks about their work, default to searching across all boards with `currentUser()` and `openSprints()`
2. Group results by status (Done, In Progress, Blocked/Waiting, Ready for Deployment, Ready for UAT, Prod, To Do, etc.)
3. Present results in a concise table format
4. If the user asks about a specific board or sprint, use the board-specific commands
5. When transitioning items, use `--yes` flag to skip confirmation prompts
6. When blocking items, transition to "Blocked/Waiting" AND create a "Blocks" link to the blocking issue
7. When stepping items through deployment pipeline, transition through required intermediate states

## Invocation

This skill is designed to be used as an OpenCode subagent (`jira-work`). When invoked, execute the
requested Jira operation(s) and return a concise summary of results or actions taken. Do not continue
the conversation — complete the task and report back.
