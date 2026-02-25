# penguins-recovery

Unified Linux system recovery toolkit. Combines multiple recovery and rescue
projects into a modular architecture with pluggable builders.

## Structure

```
penguins-recovery/
├── bootloaders/          # Debian bootloader packaging (from penguins-bootloaders)
├── builders/
│   ├── debian/           # Debian-based rescue Live CD (from mini-rescue)
│   ├── arch/             # Arch-based disk rescue image (from platter-engineer)
│   ├── uki/              # Unified Kernel Image rescue (from rescue-image1)
│   └── rescatux/         # Rescatux live-build based rescue CD (from rescatux)
├── tools/
│   └── rescapp/          # GUI rescue wizard - Qt5/kdialog (from rescapp)
├── recovery-manager/     # Recovery partition management (from pop-os/upgrade)
├── common/
│   ├── tool-lists/       # Shared package definitions across builders
│   ├── scripts/          # Shared rescue scripts (chroot, GRUB, UEFI, passwords)
│   └── branding/         # Boot menus, splash screens, MOTD
└── integration/
    └── eggs-plugin/      # Integration hook for penguins-eggs
```

## Builders

| Builder | Base | Build Tool | Output | Source |
|---------|------|------------|--------|--------|
| debian  | Debian | debootstrap | ISO | [loaden/mini-rescue](https://github.com/loaden/mini-rescue) |
| arch    | Arch Linux | mkarchiso | ISO | [RouHim/platter-engineer](https://github.com/RouHim/platter-engineer) |
| uki     | Arch Linux | mkosi | EFI executable | [swsnr/rescue-image](https://github.com/swsnr/rescue-image) |
| rescatux | Debian | live-build | ISO | [rescatux/rescatux](https://github.com/rescatux/rescatux) |

## Tools

### Rescapp

GUI rescue wizard (Python3/Qt5) with plugin-based rescue tasks:

- GRUB restore and update
- Linux/Windows password reset
- UEFI boot entry management
- Filesystem check and repair
- Disk partitioning (GParted, TestDisk, PhotoRec launchers)
- Windows MBR restore

All GTK dependencies (zenity, GObject mainloop) have been converted to
Qt equivalents (kdialog, PyQt5 DBus).

Source: [rescatux/rescapp](https://github.com/rescatux/rescapp)

## Recovery Manager

Extracted from [pop-os/upgrade](https://github.com/pop-os/upgrade). Handles:
- Recovery partition detection and version tracking
- ISO fetching with checksum verification
- System repair (fstab, crypttab, packaging)

See [recovery-manager/README.md](recovery-manager/README.md) for status.

## Shared Scripts

- `chroot-rescue.sh` -- Mount and chroot into an installed system (supports LUKS)
- `detect-disks.sh` -- Display disk layout, LUKS, LVM, and EFI info
- `grub-restore.sh` -- Restore GRUB bootloader to MBR/EFI
- `password-reset.sh` -- Reset a Linux user's password from rescue
- `uefi-repair.sh` -- Check and repair UEFI boot entries

## penguins-eggs Integration

The `integration/eggs-plugin/` directory provides a hook for
[penguins-eggs](https://github.com/pieroproietti/penguins-eggs) to embed
recovery tools into generated live ISOs.

## Building

```bash
make help          # Show all targets
make bootloaders   # Package Debian bootloaders
make debian        # Build Debian rescue ISO
make arch          # Build Arch rescue ISO
make uki           # Build UKI rescue EFI image
make rescatux      # Build Rescatux ISO
make clean         # Remove build artifacts
```

## License

GPL-3.0. The `builders/uki/` directory retains its original EUPL-1.2 license
(compatible with GPL-3.0 per the EUPL compatibility clause).

## Origins

This project unifies:
- [pieroproietti/penguins-bootloaders](https://github.com/pieroproietti/penguins-bootloaders)
- [loaden/mini-rescue](https://github.com/loaden/mini-rescue)
- [RouHim/platter-engineer](https://github.com/RouHim/platter-engineer)
- [swsnr/rescue-image](https://github.com/swsnr/rescue-image)
- [pop-os/upgrade](https://github.com/pop-os/upgrade)
- [rescatux/rescatux](https://github.com/rescatux/rescatux)
- [rescatux/rescapp](https://github.com/rescatux/rescapp)
