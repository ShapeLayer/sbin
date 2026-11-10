#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
command_dir="$repo_dir/sbin"

mkdir -p "$HOME/bin"

for command_path in "$command_dir"/*; do
  [[ -f "$command_path" ]] || continue
  chmod +x "$command_path"
  ln -sfn "$command_path" "$HOME/bin/$(basename "$command_path")"
done

grep -qF 'HOME/bin' ~/.zshrc 2>/dev/null || cat >> ~/.zshrc <<'EOF'

case ":$PATH:" in
  *":$HOME/bin:"*) ;;
  *) export PATH="$HOME/bin:$PATH" ;;
esac
EOF

echo "Installed commands to $HOME/bin. Run 'exec zsh' (or open a new terminal) to reload PATH."
