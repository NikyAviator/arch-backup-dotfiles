#!/usr/bin/env bash
set -euo pipefail

# --- SETTINGS (edit if your mount path differs) ---
USB_MOUNT="/run/media/niky/LinuxBackupUSB"
DEST_ROOT="$USB_MOUNT/arch-backup"
STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="$DEST_ROOT/$HOSTNAME-$STAMP"

# --- sanity checks ---
if [ ! -d "$USB_MOUNT" ]; then
  echo " USB not mounted at $USB_MOUNT"; exit 1
fi
mkdir -p "$DEST"

echo " Backing up dotfiles to: $DEST"

# Build include rules (order matters: include first, then exclude everything else)
INCLUDES=(
  "--include=.zshrc"
  "--include=.zsh_history"
  "--include=.p10k.zsh"
  "--include=.gitconfig"

  "--include=.config/kdeglobals"
  "--include=.config/kwinrc"
  "--include=.config/kglobalshortcutsrc"
  "--include=.config/plasma-org.kde.plasma.desktop-appletsrc"
  "--include=.config/konsolerc"
  "--include=.config/konsolesshconfig"
  "--include=.config/kwinoutputconfig.json"

  "--include=.config/htop/***"
  "--include=.config/yay/***"
  "--include=.config/gtk-3.0/***"
  "--include=.config/gtk-4.0/***"
  "--include=.oh-my-zsh/***"                    
  "--include=.ssh/***"                           
  "--exclude=*"
)

# Run rsync *from* $HOME so patterns match cleanly
cd "$HOME"

# -a  : archive (recursive, perms, times, etc.)
# -R  : same as --relative (preserve leading paths)
# We pass INCLUDES array to ensure full recursion for selected paths only.
rsync -avh --info=stats1,progress2 --prune-empty-dirs --mkpath --protect-args \
  "${INCLUDES[@]}" ./ "$DEST"

echo " Done. Backup snapshot created at: $DEST"
echo " (Next time you'll get another timestamped snapshot in $DEST_ROOT)"
