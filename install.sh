#!/usr/bin/env bash
# Run by `coder dotfiles` on workspace start. Idempotent.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "skipping $dest, a real file is already there"
    return
  fi
  ln -sfn "$src" "$dest"
}

# Personal Claude Code layer: rules, skills and agents that sit on top of each repo's own.
for kind in rules skills agents; do
  mkdir -p "$HOME/.claude/$kind"
  for src in "$DOTFILES/claude/$kind"/*; do
    [ -e "$src" ] || continue
    link "$src" "$HOME/.claude/$kind/$(basename "$src")"
  done
done

# A few of Matt Pocock's skills (github.com/mattpocock/skills), the ones superpowers has no equivalent for.
MATT="$HOME/.cache/mattpocock-skills"
if [ -d "$MATT/.git" ]; then
  git -C "$MATT" pull -q --ff-only || echo "could not update $MATT, keeping the current copy"
else
  git clone -q --depth 1 https://github.com/mattpocock/skills.git "$MATT"
fi
for skill in \
  engineering/to-spec \
  engineering/to-tickets \
  engineering/prototype \
  engineering/research \
  engineering/codebase-design \
  productivity/handoff \
  productivity/writing-for-agents; do
  link "$MATT/skills/$skill" "$HOME/.claude/skills/$(basename "$skill")"
done
