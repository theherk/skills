---
name: nabu
description: Per-project memory and knowledge notes in Obsidian vaults
triggers:
  - nabu
  - memory
  - project notes
  - project memory
---

# Nabu - Project Memory System

Nabu maintains structured per-project notes in Obsidian vaults. Each repository gets one note, mapped by its origin remote to the appropriate vault.

## Vault Mapping

Determine the vault by matching the `~/projects/` subdirectory prefix of the current repository:

| Project directory prefix | Vault path |
|--------------------------|------------|
| `~/projects/github.com/` | `~/vaults/brain` |
| `~/projects/sr.ht/` | `~/vaults/brain` |
| `~/projects/gitlab.com/` | `~/vaults/brain` |
| `~/projects/gitlab.tech.dnb.no/` | `~/Library/CloudStorage/OneDrive-DNBBankASA/dnbrain` |
| `~/projects/dnb.ghe.com/` | `~/Library/CloudStorage/OneDrive-DNBBankASA/dnbrain` |

## Note Path Convention

Notes mirror the `~/projects/` directory structure within the vault:

`<vault>/nabu/<forge>/<namespace>[/subgroup...]/<repo>.md`

The path after `nabu/` is identical to the path after `~/projects/`. This handles nested namespaces (common on GitLab) without ambiguity and makes the forge explicit.

Examples:
- `~/vaults/brain/nabu/github.com/theherk/commons.md`
- `~/vaults/brain/nabu/github.com/anomalyco/opencode.md`
- `~/Library/CloudStorage/OneDrive-DNBBankASA/dnbrain/nabu/gitlab.tech.dnb.no/ccplat/terraform-modules.md`
- `~/Library/CloudStorage/OneDrive-DNBBankASA/dnbrain/nabu/gitlab.tech.dnb.no/ccplat/subgroup/repo.md`

## Determining the Current Project

1. Run `git remote get-url origin` in the working directory
2. Parse the forge domain and full path from the URL
   - SSH: `git@github.com:theherk/commons.git` -> `github.com/theherk/commons`
   - HTTPS: `https://github.com/theherk/commons.git` -> `github.com/theherk/commons`
   - Nested: `git@gitlab.tech.dnb.no:ccplat/subgroup/repo.git` -> `gitlab.tech.dnb.no/ccplat/subgroup/repo`
3. Map the forge domain to a vault using the table above
4. Construct the note path: `<vault>/nabu/<forge>/<path>.md`

## Note Template

When creating a new note, use this structure:

```markdown
---
tags:
  - dev
  - nabu
---

# Nabu - <forge>/<namespace>/<repo>

Brief description of the project.

## Patterns

Key architectural patterns, conventions, and decisions.

## Session Notes

Chronological notes from working sessions. Use `### YYYY-MM-DD` subheadings.

## Plans

Ongoing plans, next steps, open questions.

## Related Tickets

Links to Jira issues, GitHub issues, or MRs/PRs relevant to current work.

## Related Notes

Cross-references to other Nabu notes or vault documents.
```

## Operations

### Read

Default when invoked without explicit write intent.

1. Determine the note path for the current project
2. Read and return its content
3. If the note does not exist, say so and offer to create it

### Create

1. Determine the note path
2. Create parent directories if needed (`mkdir -p`)
3. Populate from the template above
4. Gather initial info from README, CLAUDE.md, or other project docs if available
5. Confirm creation to the caller

### Update

1. Read the existing note
2. Append or edit the relevant section with new information
3. Preserve existing content and structure
4. For session notes, add a dated subheading if one doesn't exist for today

### Link

Add cross-references in the Related Notes section using Obsidian links:

- Same vault: `[[nabu/github.com/theherk/commons]]`
- Cross-vault deep link: `[Label](obsidian://open?vault=brain&file=nabu%2Fgithub.com%2Ftheherk%2Fcommons)`

## Process

1. Determine current repo via `git remote get-url origin`
2. Parse forge and full repo path, then map to vault
3. Construct note path: `<vault>/nabu/<forge>/<path>.md`
4. Check if note exists (use glob or read)
5. Perform the requested operation (read/create/update/link)
6. Return concise confirmation of what was done

## Obsidian CLI

The `obsidian` CLI provides vault-aware operations. Use it for searching notes, reading content, and querying vault structure. Target a vault with `vault=<name>`.

### Key commands for Nabu

```sh
# Search across a vault (text search, returns matching files with context)
obsidian search query="<text>" vault=brain
obsidian search query="<text>" vault=dnbrain path=nabu

# Search with line context
obsidian search:context query="<text>" vault=brain path=nabu

# Read a note by path
obsidian read vault=brain path="nabu/github.com/theherk/commons.md"

# List files in the nabu folder
obsidian files vault=brain folder=nabu

# Get backlinks to a note
obsidian backlinks vault=brain path="nabu/github.com/theherk/commons.md"

# List tags
obsidian tags vault=brain path="nabu/github.com/theherk/commons.md"
```

Prefer `obsidian search` over grep when looking for notes or content across a vault. It uses Obsidian's index and respects vault structure.

## Guidelines

- Keep notes brief and structured. This content will be fed into context.
- Use mermaid diagrams where they add clarity for architecture or flows.
- Do not duplicate information that lives in CLAUDE.md or README -- reference it instead.
- One note per origin repository. No notes for forks/mirrors that share an origin.
- When updating, preserve all existing content. Append, do not overwrite.
- Session notes should capture decisions, discoveries, and blockers -- not play-by-play.
