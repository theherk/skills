# skills

Custom skills for Claude Code that extend its capabilities with specialized functionality.

## What are Skills?

Skills are reusable capabilities that Claude Code can invoke during sessions to perform specialized tasks. When a user's request matches a skill's purpose, Claude Code automatically uses that skill to complete the task.

## Available Skills

- **improve-docs**: Evaluates and improves documentation for correctness, clarity, and completeness

## Setup

Run the setup script to install these skills:

```bash
./linker.sh
```

This script will:
1. Remove the legacy `~/.claude/skills` symlink if it points at this repo (no back-compat)
2. Replace a whole-directory `~/.agents/skills` symlink (the old layout) with a real directory
3. Symlink each skill in this repository into `~/.agents/skills/<skill>`
4. Make all skills immediately available in any Agent-Skills-compatible harness (opencode, goose, Crush, etc.)

It only creates links (same-named links are overwritten, last wins) and never prunes, so other skill repositories can be linked into the same directory. It is safe to run multiple times.

## Using Skills

Once installed, skills are automatically available. Invoke them using the `/` command (opencode) or natural language / `/skills <name>` (goose):

```
/improve-docs README.md
```

Agents will also proactively suggest relevant skills based on your requests.

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
