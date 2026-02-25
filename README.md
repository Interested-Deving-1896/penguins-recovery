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
│   └── uki/              # Unified Kernel Image rescue (from rescue-image1)
├── recovery-manager/     # Recovery partition management (from pop-os/upgrade)
├── common/
│   ├── tool-lists/       # Shared package definitions across builders
│   ├── scripts/          # Shared rescue scripts (chroot, disk detection)
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

## Recovery Manager

Extracted from [pop-os/upgrade](https://github.com/pop-os/upgrade). Handles:
- Recovery partition detection and version tracking
- ISO fetching with checksum verification
- System repair (fstab, crypttab, packaging)

See [recovery-manager/README.md](recovery-manager/README.md) for status and adapter requirements.

## Shared Scripts

- `common/scripts/chroot-rescue.sh` -- Mount and chroot into an installed system (supports LUKS)
- `common/scripts/detect-disks.sh` -- Display disk layout, LUKS, LVM, and EFI info

## penguins-eggs Integration

The `integration/eggs-plugin/` directory provides a hook for
[penguins-eggs](https://github.com/pieroproietti/penguins-eggs) to embed
recovery tools into generated live ISOs.

## License

GPL-3.0. The `builders/uki/` directory retains its original EUPL-1.2 license
(compatible with GPL-3.0 per the EUPL compatibility clause).

## Origins

This project unifies forks from:
- [pieroproietti/penguins-bootloaders](https://github.com/pieroproietti/penguins-bootloaders)
- [loaden/mini-rescue](https://github.com/loaden/mini-rescue)
- [RouHim/platter-engineer](https://github.com/RouHim/platter-engineer)
- [swsnr/rescue-image](https://github.com/swsnr/rescue-image)
- [pop-os/upgrade](https://github.com/pop-os/upgrade)
