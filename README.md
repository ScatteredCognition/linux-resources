# Fedora-KDE-setup-guide
My personal Fedora KDE setup guide.

**It is recommended to install/rebase and use the [`kinoite-mahrus`](https://github.com/faeizmahrus/kinoite-mahrus) Fedora Kinoite image.**

Everything is preinstalled in the `kinoite-mahrus` image, only post-install configuration is needed.<br>
The Syncthing service needs to be enabled.

## For traditional Fedora KDE :
- [Initial Setup](initial-setup.md)
- [Compiling OpenBangla Keyboard](obk-compile.md)

## For both :
- Change the default user shell : [`fish`](fish-shell.md)
- If using Full Disk Encryption with LUKS : [TPM autounlock](tpm-autounlock.md)


# Post-install Stuff
## Installing Appimages
Use the Gear Lever app from Flathub to install and set launch arguments for Appimages you have downloaded.

```
flatpak install it.mijorus.gearlever
```

## Web browsing
- Brave Browser - [(Install)](https://brave.com/linux/) : [(Electron)](electron-args-flags.md)
- KeePassXC - (needs [Sync stuff](#sync-stuff))

```
sudo dnf install -y keepassxc
flatpak install -y org.keepassxc.KeePassXC
```

## Notetaking
- Obsidian - [(Appimage)](#installing-appimages) : [(Download)](https://obsidian.md/download) : [(Electron)](electron-args-flags.md) (needs [Sync stuff](#sync-stuff)) <br>

## Sync stuff
- Syncthing : `sudo dnf install -y syncthing` <br>
- Enable the service :
```
systemctl --user --now enable syncthing.service
```

## Office work
Do basic word processing, presentation and worksheet creation.
### Tools required
- LibreOffice

```
sudo dnf install -y libreoffice
flatpak install -y org.libreoffice.LibreOffice
```

- OnlyOffice Desktop Editors - [(Install)](https://www.onlyoffice.com/download-desktop.aspx?from=desktop) (only supports Zotero online)
- OpenBangla Keyboard - [(Guide)](obk-compile.md)
- Microsoft Office - [(Download)](https://massgrave.dev) (inside a VM)
- Zotero 7 (unofficial) - [(Appimage)](#installing-appimages) : [(Download)](https://github.com/ryuuzaki42/Zotero_AppImage) <br>
If you encounter the error with Zotero 7 : <br>

```
libdbus-glib-1.so.2: cannot open shared object file: No such file or directory Couldn't load XPCOM
``` 

Install `dbus-glib` : `sudo dnf install -y dbus-glib`

## Graphics Design
- Krita : `sudo dnf install -y krita`
- GIMP : `sudo dnf install -y gimp`
- Affinity Suite (inside a VM)

## Virtual machines
Create and run VMs for Windows-only tools.
### Tools required
- virt-manager : `sudo dnf install -y virt-manager` <br> (needs additional setup, unfinished)
- Windows virtIO guest drivers [(Download ISO)](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/)
- RDP (optional)
- Intel iGPU SRIOV (someday soon)
- VMWare Workstation - [(Download)](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion) : [(Mirror)](https://www.techspot.com/downloads/189-vmware-workstation-for-windows.html) <br>
(offers full DirectX acceleraion, better and faster, but you lose secure boot)

## Rust development
- distrobox : `sudo dnf install -y distrobox`
- Visual Studio Code - [(Install)](https://code.visualstudio.com/download) : [(Electron)](electron-args-flags.md)
- git : `sudo dnf install -y git`
- rust & rust-analyzer : `sudo dnf install -y rust rust-analyzer`

