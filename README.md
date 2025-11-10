# arch-backup-dotfiles

This is a custom made bash script with it's purpose to save my current Arch Linux with KDE Plasma setup.

This is for backup and to get up and running quickly on a fresh install!

---

1. Plug in your USB

Make sure your backup USB stick is mounted at:

```bash
lsblk
/run/media/niky/LinuxBackupUSB
```

---

2. Save the script on your Arch system

Place the file anywhere you like — for example in your home directory:

```bash
~/backup_dotfiles.sh
```

Then make it executable:

```bash
chmod +x ~/backup_dotfiles.sh
```

---

3. Run the backup

In a terminal:

```bash
~/backup_dotfiles.sh
```
