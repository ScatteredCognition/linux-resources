# Linux resources
Github repo to archive and share my resources regarding linux.
- INSTALLING NORMAL FEDORA IS A HASSLE, IF YOU REALLY MUST, HERE'S THE GUIDE - [(guide)](guides/initial-setup.md)

## Fedora Quick Start
- Install Fedora Silverblue/Kinoite. [(torrent)](https://torrents.fedoraproject.org/)
- Rebase onto custom [`kinoite-mahrus`](https://github.com/faeizmahrus/os-images) image. <br>
  ```bash
  ## Rebase onto unverified image
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/faeizmahrus/kinoite-mahrus:latest

  ## Reboot to boot into it
  systemctl reboot

  ## Rebase onto signed image
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/faeizmahrus/kinoite-mahrus:latest

  ## Reboot to boot into it
  systemctl reboot

  ## Pin the current image and remove the previous ones
  sudo ostree admin pin 0
  rpm-ostree cleanup -rpmb
  ```

- Enable Flathub repo & disable Fedora flatpak repos <br>
  ```bash
  ## Delete fedora remotes
  flatpak remote-delete fedora
  flatpak remote-delete fedora-testing
  
  ## Add flathub remote as user (remove --user flag to install as system)
  flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  ```

- Change the default user shell : [`fish`](guides/fish-shell.md)
- If using Full Disk Encryption with LUKS : [TPM autounlock](guides/tpm-autounlock.md)
- Enable OpenBangla Keyboard with fcitx (TODO) [(how to compile)](guides/obk-compile.md)
- Enable syncthing service: <br>
  `systemctl --user --now enable syncthing.service`


## NOTE:
- Compiling OpenBangla Keyboard - [(guide)](guides/obk-compile.md)
- Zotero 7 (unofficial) - [(Appimage)](#installing-appimages) : [(Download)](https://github.com/ryuuzaki42/Zotero_AppImage) <br>
If you encounter the error with Zotero 7 : <br>

```
libdbus-glib-1.so.2: cannot open shared object file: No such file or directory Couldn't load XPCOM
``` 

Install `dbus-glib` : `sudo dnf install -y dbus-glib`