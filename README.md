# Linux resources
Github repo to archive and share my resources regarding linux.
- INSTALLING NORMAL FEDORA IS A HASSLE, IF YOU REALLY MUST, HERE'S THE GUIDE - [(guide)](guides/initial-setup.md)

## Fedora Quick Start
- Install Fedora Silverblue/Kinoite. [(torrent)](https://torrents.fedoraproject.org/)
- Rebase onto custom `-mahrus` image. [(link)](https://github.com/faeizmahrus/os-images) <br>
- Enable Flathub repo & disable Fedora flatpak repos <br>
  ```bash
  ## Delete fedora remotes
  flatpak remote-delete fedora
  flatpak remote-delete fedora-testing
  
  ## Add flathub remote as user (use --system flag to install as system)
  ## Should get auto-installed with the latest images
  flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  ```
- Install VSCode, Obsidian and OnlyOffice from distrobox <br>
  ```bash
  ## Create container
  DBX_NON_INTERACTIVE=1 distrobox create \
  -i ghcr.io/faeizmahrus/appbox-debian \
  -n appbox \
  --hostname appbox \
  -H ~/.local/distrobox/appbox/

  ## Export apps
  distrobox enter appbox -- appbox-export
  ```

- Change the default user shell : [`fish`](guides/fish-shell.md)
- If using Full Disk Encryption with LUKS : [TPM autounlock](guides/tpm-autounlock.md)
- Enable syncthing service: <br>
  `systemctl --user --now enable syncthing.service`


## NOTE:
- Compiling OpenBangla Keyboard - [(guide)](guides/obk-compile.md)
- Useful flags for Electron apps or Chromium - [(guide)](guides/electron-args-flags.md)
- Enable OpenBangla Keyboard with fcitx (TODO)