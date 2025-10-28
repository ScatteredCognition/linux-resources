# Tweaks and advice to make Fedora Silverblue a more bearable experience
## IMPORTANT INFO
With Fedora Silverblue 42 and later, the ComposeFS changes require some manual intervention for a "sane" user experience.
- Comment out the line for the `/` mount in `/etc/fstab` to fix the `systemd-remount-fs.service` errors.
- Mount `/` btrfs subvolume with compression `rpm-ostree kargs --delete=rootflags=subvol=root --append=rootflags=subvol=root,compress=zstd:1`
- To trim the root subvol, do `sudo fstrim /sysroot`

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
- `compsize /sysroot /var/home /var/lib/flatpak` | Finds out how much space you saved using zstd compression