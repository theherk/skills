#!/usr/bin/env bash

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.agents/skills"
BACKUP_DIR="$HOME/.agents/skills_backup_$(date +%Y%m%d_%H%M%S)"
LEGACY_CLAUDE_DIR="$HOME/.claude/skills"

# Drop the legacy .claude/skills symlink if it points at this repo. No back-compat;
# canonical location is ~/.agents/skills, which opencode, goose, crush, and OMP all
# read natively.
if [ -L "$LEGACY_CLAUDE_DIR" ] && [ "$(readlink "$LEGACY_CLAUDE_DIR")" = "$REPO_DIR" ]; then
	rm "$LEGACY_CLAUDE_DIR"
fi

[ -L "$SKILLS_DIR" ] && [ "$(readlink "$SKILLS_DIR")" = "$REPO_DIR" ] && exit 0

[ -e "$SKILLS_DIR" ] && [ ! -L "$SKILLS_DIR" ] && mv "$SKILLS_DIR" "$BACKUP_DIR"
[ -L "$SKILLS_DIR" ] && rm "$SKILLS_DIR"

mkdir -p "$HOME/.agents"
ln -s "$REPO_DIR" "$SKILLS_DIR"
