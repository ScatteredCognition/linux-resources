## Configure TPM autounlock with LUKS FDE
### Atleast on Fedora 41, TPM autounlock of LUKS volumes with `systemd-cryptenroll` works ootb with no further install/modification of anything
Resources used : [jdoss's guide](https://gist.github.com/jdoss/777e8b52c8d88eb87467935769c98a95) - [uapi-group](https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/) - [ArchWiki](https://wiki.archlinux.org/title/Systemd-cryptenroll)

The /etc/crypttab and other stuff seem unnecessary, atleast for Fedora 41.

**IF YOU HAVE MULTIPLE TPM DEVICES, SPECIFY THE TPM TO BE USED BY ENTERING THE FULL PATH TO THE TPM DEVICE (`/dev/<TPM2_DEVICE>`) IN `--tpm2-device=` DURING ENROLL**

### Check if everything is setup correctly
- See which volume(s) are LUKS encrypted
```
sudo blkid -t TYPE=crypto_LUKS
```
- See whether secureboot is enabled
```
sudo mokutil --sb-state
```
- See available TPM devices
```
sudo systemd-cryptenroll --tpm2-device=list
```

### Enroll TPM2 to LUKS
- Enroll the LUKS volumes
```
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=1+5+7+14 /dev/<LUKS_Volume_name>
```
- Enroll a recovery key (QR Code) 
```
sudo systemd-cryptenroll --recovery-key /dev/<LUKS_Volume_name>
```
- Reboot to see whether it worked
```
systemctl reboot
```

### Remove TPM2 from LUKS
- Disable TPM autounlock
```
sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/<LUKS_Volume_name>
```
- Re-enroll TPM
```
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=1+5+7+14 /dev/<LUKS_Volume_name>
```

### Description of the TPM PCRs (in linux)
- `PCR 1` - **Changes to Hardware** (Changing/Adding/Removing RAM/CPU/GPU etc)
- `PCR 5` - **GPT Partition Table was changed** (Creating/Deleting/Modifying partitions)
- `PCR 7` - **Changes to UEFI Secureboot**
- `PCR 14` - **Changes to Secureboot "MOK" certificates and keys** (Enrolling new Secureboot keys)
