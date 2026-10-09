#!/usr/bin/env bash
# Run by `coder dotfiles` on workspace start. Idempotent.
set -euo pipefail

command -v claude >/dev/null || { echo "claude not on PATH, skipping skills"; exit 0; }

claude plugin marketplace add mattpocock/skills --scope user 2>/dev/null || true
claude plugin install mattpocock-skills@mattpocock --scope user 2>/dev/null \
  || claude plugin marketplace update mattpocock
