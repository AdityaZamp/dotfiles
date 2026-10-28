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

# Superpowers plugin, so every session starts with its skills. Both commands are no-ops when already done.
if command -v claude >/dev/null; then
  claude plugin marketplace add anthropics/claude-plugins-official </dev/null >/dev/null &&
    claude plugin install superpowers@claude-plugins-official </dev/null >/dev/null ||
    echo "could not install the superpowers plugin"
else
  echo "claude not on PATH, skipping the superpowers plugin"
fi
