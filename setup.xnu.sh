#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
command_dir="$repo_dir/sbin"

mkdir -p "$HOME/sbin"

for command_path in "$command_dir"/*; do
  [[ -f "$command_path" ]] || continue
  chmod +x "$command_path"
  ln -sfn "$command_path" "$HOME/sbin/$(basename "$command_path")"
done

grep -qF 'HOME/sbin' ~/.zshrc 2>/dev/null || cat >> ~/.zshrc <<'EOF'

case ":$PATH:" in
  *":$HOME/sbin:"*) ;;
  *) export PATH="$HOME/sbin:$PATH" ;;
esac
EOF

source ~/.zshrc
