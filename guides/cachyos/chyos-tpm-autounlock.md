# Guide for setting up auto-unlocking LUKS2 volumes on boot with a TPM2 chip on CachyOS (August 2025)

**You need use `systemd-boot` for this to work properly.**

- Make a copy of your `/etc/crypttab` for initramfs
```bash
sudo cp /etc/crypttab /etc/crypttab.initramfs
```
- Make a backup of your /etc/mkinitcpio.conf
```bash
sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
```
- Include the necessary systemd stuff in your initramfs by replacing the following in your `/etc/mkinitcpio.conf` file: <br>
- - `udev` > `systemd`
- - `keymap` and `consolefont` > `sd-vconsole`
- - `encrypt` > `sd-encrypt`
- - Example:
- - Original:
```bash
HOOKS=(base udev autodetect microcode kms modconf block keyboard keymap consolefont plymouth encrypt filesystems)
```
- - Modified:
```bash
HOOKS=(base systemd plymouth autodetect microcode modconf kms keyboard sd-vconsole sd-encrypt block filesystems fsck)
```
- Regenerate your initramfs
```bash
sudo mkinitcpio -P
```

### Continue onwards with the guide below
[Main guide](/guides/misc/tpm-autounlock.md)