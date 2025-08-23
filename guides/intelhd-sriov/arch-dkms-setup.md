# Guide for setting up SR-IOV for Intel UHD Graphics (12th gen onwards)

### Quick Summary
SR-IOV is a virtualization technology that allows a single device to be virtualized into multiple virtualied devices.

This means, with SR-IOV for our Intel iGPU, we can simultaneously use the single iGPU for multiple OSes, this is especially useful for VMs, as we can pass a vGPU instance to the VM and enjoy full HW Acceleration.

### Additional Information
Note that this guide enables support for SR-IOV with the i915 driver.
Intel has a newer Xe driver that is meant to supersede the i915 driver. It already supports SR-IOV for the iGPUs but the support hasn't been enabled yet.

Hopefully, The mainline Xe driver will enable SR-IOV support OOTB in the 6.18 kernel. [Follow this Github discussion for more news](https://github.com/intel/linux-intel-lts/issues/33#issuecomment-3198883099)

### Setting up the kernel stuff
**You need Linux Kernel 6.12 LTS for this to work, anything older or newer is not guranteed to work.**

- Install `linux-cachyos-lts` or `linux-lts` kernels (ensure current LTS is 6.12)
- If current LTS is not 6.12, Build/Install the kernel from the archive. <br> [`linux-lts`](https://archive.archlinux.org/packages/l/linux-lts/) [`linux-lts-docs`](https://archive.archlinux.org/packages/l/linux-lts-docs/) [`linux-lts-headers`](https://archive.archlinux.org/packages/l/linux-lts-headers/)
- Goto [i915-sriov-dkms](https://github.com/strongtz/i915-sriov-dkms) GitHub and download the latest .pkg.tar.zstd file for Arch Linux under the Releases tab
- Run `sudo pacman pacman -U <filename>` to install the dkms module (WARNING: Installation will take a LONG time)
- As of the current/latest release, you can auto-configure some misc. variables by editing these two files and uncommenting some lines:
  - `/etc/modprobe.d/i915-sriov-dkms.conf`
  - `/etc/tmpfiles.d/i915-set-sriov-numvfs.conf`
- Add `intel_iommu=on` to your kargs
- **Reboot**
- Congratulations, everything should be working now.
- If the VFS don't get created, do:
```bash
sudo sh
echo 3 > /sys/devices/pci0000:00/0000:00:02.0/sriov_numvfs
```

### Setting up the VMs
You can setup VMs using the vGPUs by following [this guide.](/guides/intelhd-sriov/vm-creation.md)