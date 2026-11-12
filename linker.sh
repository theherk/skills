#!/usr/bin/env bash
# Symlink each skill in this repo into ~/.agents/skills. Create-only: existing links of the
# same name are overwritten (last wins); real directories are never replaced (skipped with a
# warning); nothing is pruned, so other skill repos can coexist.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.agents/skills"
LEGACY_CLAUDE_DIR="$HOME/.claude/skills"

# Drop the legacy .claude/skills symlink if it points at this repo.
if [ -L "$LEGACY_CLAUDE_DIR" ] && [ "$(readlink "$LEGACY_CLAUDE_DIR")" = "$REPO_DIR" ]; then
	rm "$LEGACY_CLAUDE_DIR"
fi

# A whole-directory symlink (the old layout) would make us write into the repo it points at.
[ -L "$SKILLS_DIR" ] && rm "$SKILLS_DIR"
mkdir -p "$SKILLS_DIR"

for skill_file in "$REPO_DIR"/*/SKILL.md; do
	skill_dir="$(dirname "$skill_file")"
	name="$(basename "$skill_dir")"
	target="$SKILLS_DIR/$name"
	if [ -e "$target" ] && [ ! -L "$target" ]; then
		echo "skipped $name: $target exists and is not a symlink" >&2
		continue
	fi
	ln -sfn "$skill_dir" "$target"
done
