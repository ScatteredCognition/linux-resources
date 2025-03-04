## Configure TPM autounlock with LUKS FDE
### On Fedora 41, TPM autounlock of LUKS volumes with `systemd-cryptenroll` works ootb with no further install/modification of anything
Resources used : [jdoss's guide](https://gist.github.com/jdoss/777e8b52c8d88eb87467935769c98a95) - [uapi-group](https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/) - [ArchWiki](https://wiki.archlinux.org/title/Systemd-cryptenroll) - [FreeDesktop](https://www.freedesktop.org/software/systemd/man/latest/systemd-cryptenroll.html) - [AskUbuntu](https://askubuntu.com/questions/1357694/trying-to-understand-errors-from-tpm2-tools) - [tpm2-tools readthedocs](https://tpm2-tools.readthedocs.io)

The /etc/crypttab and other stuff seem unnecessary, atleast for Fedora 41.

**IF YOU HAVE MULTIPLE TPM DEVICES, SPECIFY THE TPM TO BE USED BY ENTERING THE FULL PATH TO THE TPM DEVICE (`/dev/<TPM2_DEVICE>`) IN `--tpm2-device=` DURING ENROLL**

**UNPLUG ANY BOOTABLE EXTERNAL STORAGE DEVICES OR INSTALL MEDIA AND REBOOT BEFORE ENROLLING TPM AUTOUNLOCK**

**NEED TO BE RE-ENROLLED AFTER SECUREBOOT DBX AND UEFI FIRMWARE UPDATES**

### Check if everything is setup correctly
- See which volume(s) are LUKS encrypted
```bash
sudo blkid -t TYPE=crypto_LUKS
```
- See whether secureboot is enabled
```bash
sudo mokutil --sb-state
```
- See available TPM devices
```bash
sudo systemd-cryptenroll --tpm2-device=list
```

### Clear the TPM chip
- Either use PPI Reset via UEFI firmware options.
- Or run the following commands to initiate a PPI reset through linux. (Recommended)
```bash
sudo sh
echo 5 > /sys/class/tpm/tpm0/ppi/request
```
- Reboot to finish the PPI reset
```bash
systemctl reboot
```

### Enroll TPM2 to LUKS
- Enroll the LUKS volumes
```bash
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=1+5+7 <LUKS_Volume>
```
- Enroll a recovery key (QR Code) 
```bash
sudo systemd-cryptenroll --recovery-key <LUKS_Volume>
```
- Reboot to see whether it worked
```bash
systemctl reboot
```

### Remove TPM2 from LUKS
- Disable TPM autounlock
```bash
sudo systemd-cryptenroll --wipe-slot=tpm2 <LUKS_Volume>
```

### Take Ownership and lock the TPM2 chip
- Set Owner, Endorsement and Lockout passwords to ensure they can't be changed by unauthorized parties. (You need to remove the locks everytime you need to re-enroll the TPM)
```bash
tpm2_changeauth -c owner newpass
tpm2_changeauth -c endorsement newpass
tpm2_changeauth -c lockout newpass
```

### Description of the TPM PCRs (in linux)
- `PCR 1` - **Hardware configuration was changed** (Changing/Adding/Removing RAM/CPU/GPU etc)
- `PCR 5` - **GPT Partition Table was changed** (Creating/Deleting/Modifying partitions)
- `PCR 7` - **Changes to UEFI Secureboot State**

#### These values require systemd-boot and/or UKIs
- `PCR 14` - **Changes to Secureboot "MOK" certificates and keys** (Enrolling new Secureboot keys)
- `PCR 15` - **Changes to `machine-id`, UUIDs of various mountpoints, other systemd measurements** [(Mitigation for this ???)](https://oddlama.org/blog/bypassing-disk-encryption-with-tpm2-unlock/)
