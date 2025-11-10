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

# We use --relative so rsync preserves the leading paths exactly as listed.
# We also include only what you want; nothing from caches, etc.
rsync -avh --relative --info=stats1,progress2 --prune-empty-dirs --mkpath --protect-args \
  --exclude ".oh-my-zsh/cache/**" \
  --exclude ".oh-my-zsh/log/**" \
  --files-from=- "$HOME"/ "$DEST" <<'FILES'
.zshrc
.zsh_history
.p10k.zsh
.oh-my-zsh/          

.gitconfig

.config/kdeglobals
.config/kwinrc
.config/kglobalshortcutsrc
.config/plasma-org.kde.plasma.desktop-appletsrc
.config/konsolerc
.config/konsolesshconfig

.config/htop/
.config/yay/
.config/gtk-3.0/
.config/gtk-4.0/

.ssh/                
FILES

echo " Done. Backup snapshot created at: $DEST"
echo " (Next time you'll get another timestamped snapshot in $DEST_ROOT)"
