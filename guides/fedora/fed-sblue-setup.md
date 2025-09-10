# Tweaks and advice to make Fedora Silverblue a more bearable experience

## Layer the following packages after install:
- `distrobox`
- `android-tools` (provides adb/fastboot stuff)
- `langpacks-xx` (replace xx with your language code)
- `podman-compose` (for use with VSCode later)
- VSCode (local package)
- OpenBangla Keyboard (local package) (ibus for Silverblue, fcitx for Kinoite)

## Useful commands
- `rpm-ostree install <package> -A` | Applies changes immediately without reboot
- `rpm-ostree reset` | Removes all overlayed packages
- `sudo ostree admin pin (-u) <index>` | Pin an image | `-u` flag to unpin
- UNFINISHED