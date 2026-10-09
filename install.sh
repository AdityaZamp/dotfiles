#!/usr/bin/env bash
# Run by `coder dotfiles` on workspace start. Idempotent.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Personal Claude Code layer: rules, skills and agents that sit on top of each repo's own.
for kind in rules skills agents; do
  mkdir -p "$HOME/.claude/$kind"
  for src in "$DOTFILES/claude/$kind"/*; do
    [ -e "$src" ] || continue
    dest="$HOME/.claude/$kind/$(basename "$src")"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "skipping $dest, a real file is already there"
      continue
    fi
    ln -sfn "$src" "$dest"
  done
done

command -v claude >/dev/null || { echo "claude not on PATH, skipping plugins"; exit 0; }

claude plugin marketplace add mattpocock/skills --scope user 2>/dev/null || true
claude plugin install mattpocock-skills@mattpocock --scope user 2>/dev/null \
  || claude plugin marketplace update mattpocock
