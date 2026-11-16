---
name: notes
description: Create and manage daily notes and work notes in Obsidian vaults
triggers:
  - daily
  - dailies
  - note
  - notes
---

# Notes

## Vaults

There are two Obsidian vaults:

1. **Personal vault**: `~/vaults/brain`
2. **Work vault (dnbrain)**: `$ONEDRIVE/dnbrain`

### What goes where

- **Daily notes (dailies)**: Always in the personal vault (`~/vaults/brain`)
- **All other work-related content**: MUST go in dnbrain (`$ONEDRIVE/dnbrain`)
- **Personal notes**: Personal vault (`~/vaults/brain`)

If you are ever unsure which vault to use, ask the user using the question tool.

## Creating Daily Notes

Use neovim with the Obsidian plugin to create daily notes, as it handles template loading automatically:

```bash
nvim +"Obsidian today" ~/vaults/brain
```

Available commands: `:Obsidian yesterday`, `:Obsidian today`, `:Obsidian tomorrow`

This opens the daily note and applies the correct journal template if the file doesn't exist yet.

If neovim/Obsidian plugin is not available, create the file manually at `~/vaults/brain/journal/YYYY-MM-DD.md`. Check existing dailies in the vault to confirm the template format.

## Note Structure

### General Note Structure

Aside from daily notes, most note have very basic structure. Frontmatter should have tags, but the total set of usable tags should be kept minimal. Use the `obsidian tags` command for the vault to find relevant tags. The first text following the frontmatter should a blank line, then h1 of the note name. For example, a note file `Interesting Note.md` should start:

```markdown
---
tags:
  - example
---

# Interesting Note
```

From there, no further h1; only h2 and below. Link to other notes as much as reasonable, and always use markdown links in lieu of wiki-style.

### Daily Note Structure

Daily notes use the following sections in order:

```markdown
## Task List

- Single bullet point task
- Another task item

## Work

Additional information on ongoing work goes here.
```

### Rules

- Tasks go in `## Task List` as single bullet points (using `-`)
- Additional context about ongoing work goes in `## Work` which comes after `## Task List`
- Keep task bullets concise and actionable

## Creating Work Notes (dnbrain)

For work-related notes that are not dailies:

```bash
nvim +"Obsidian new filename" "$ONEDRIVE/dnbrain"
```

Or create files directly in the dnbrain vault at `$ONEDRIVE/dnbrain/`.

## Process

1. Determine whether the content belongs in the personal vault or dnbrain (ask if unsure)
2. For dailies, use `nvim +"Obsidian today"` in the personal vault
3. Add task items under `## Task List` as single bullet points
4. Add work context under `## Work` if needed
5. For non-daily work notes, create them in dnbrain
