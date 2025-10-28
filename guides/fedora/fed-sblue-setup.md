# Tweaks and advice to make Fedora Silverblue a more bearable experience
## Layer the following packages after install:
- `distrobox`
- `android-tools` (provides adb/fastboot stuff)
- `langpacks-xx` (replace xx with your language code)
- `podman-compose` (for use with VSCode later)
- `syncthing` (for file sync)
- VSCode (local package)
- OpenBangla Keyboard (local package) (ibus for Silverblue, fcitx for Kinoite)

## Configure Syncthing
- Run `systemctl enable --user --now syncthing.service`
- Ensure Syncthing is updated to 2.0.0 atleast

## Manage Environment Variables
- Drop files like `~/.config/environment.d/xx-<name>.conf`
- To add ~/.local/bin to $PATH, add `PATH=~/.local/bin:$PATH`

## Useful commands
- `rpm-ostree install <package> -A` | Applies changes immediately without reboot
- `rpm-ostree reset` | Removes all overlayed packages
- `sudo ostree admin pin (-u) <index>` | Pin an image | `-u` flag to unpin
- UNFINISHED