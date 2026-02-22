#!/usr/bin/env bash

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
BACKUP_DIR="$HOME/.claude/skills_backup_$(date +%Y%m%d_%H%M%S)"

[ -L "$SKILLS_DIR" ] && [ "$(readlink "$SKILLS_DIR")" = "$REPO_DIR" ] && exit 0

[ -e "$SKILLS_DIR" ] && [ ! -L "$SKILLS_DIR" ] && mv "$SKILLS_DIR" "$BACKUP_DIR"
[ -L "$SKILLS_DIR" ] && rm "$SKILLS_DIR"

mkdir -p "$HOME/.claude"
ln -s "$REPO_DIR" "$SKILLS_DIR"
