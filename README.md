# skills

Custom skills for Claude Code that extend its capabilities with specialized functionality.

## What are Skills?

Skills are reusable capabilities that Claude Code can invoke during sessions to perform specialized tasks. When a user's request matches a skill's purpose, Claude Code automatically uses that skill to complete the task.

## Available Skills

- **improve-docs**: Evaluates and improves documentation for correctness, clarity, and completeness

## Setup

Run the setup script to install these skills:

```bash
./link_skills.sh
```

This script will:
1. Backup your existing `~/.claude/skills` directory to `~/.claude/skills_backup_<timestamp>`
2. Create a symlink from this repository to `~/.claude/skills`
3. Make all skills immediately available in Claude Code sessions

The script is idempotent and safe to run multiple times.

## Using Skills

Once installed, skills are automatically available in Claude Code. Invoke them using the `/` command:

```
/improve-docs README.md
```

Claude Code will also proactively suggest relevant skills based on your requests.

## Creating New Skills

To add a new skill:

1. Create a directory in the repository root with your skill name
2. Add a `SKILL.md` file with frontmatter defining the skill:
   ```markdown
   ---
   name: skill-name
   description: Brief description of what the skill does
   ---
   
   # Skill instructions and guidelines
   ```
3. The skill becomes available after the next Claude Code session starts

See `improve-docs/SKILL.md` for a reference implementation.
