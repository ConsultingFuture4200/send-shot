#!/usr/bin/env bash
# Install send-shot.sh to ~/.local/bin and seed a config file.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/send-shot.sh"
bindir="${HOME}/.local/bin"
confdir="${XDG_CONFIG_HOME:-$HOME/.config}/send-shot"
conf="$confdir/config"

mkdir -p "$bindir" "$confdir"
install -m 0755 "$src" "$bindir/send-shot.sh"
echo "installed: $bindir/send-shot.sh"

if [ -e "$conf" ]; then
  echo "kept existing config: $conf"
else
  cat > "$conf" <<'TEMPLATE'
# Where screenshots get sent. Required.
# An ssh_config alias, or user@host, or user@192.168.1.180
SHOT_REMOTE=

# Destination directory on the remote machine. Optional.
# Defaults to "screenshots" in the remote user's home directory.
# An absolute path here avoids an extra ssh round-trip per screenshot.
#SHOT_DEST=/home/you/screenshots
TEMPLATE
  echo "wrote starter config: $conf"
  echo
  echo "Next: set SHOT_REMOTE in $conf, then bind a key (see README)."
fi

case ":$PATH:" in
  *":$bindir:"*) ;;
  *) echo; echo "warning: $bindir is not on your PATH" >&2 ;;
esac
