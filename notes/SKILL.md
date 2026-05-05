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

## Daily Note Structure

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
