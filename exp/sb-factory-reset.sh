#!/usr/bin/env bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root." >&2
  exit 1
fi

# Ensure /etc/fstab and /etc/crypttab exist, restore from /var/etc if missing
if [ ! -f /etc/fstab ]; then
  echo "/etc/fstab not found."
  echo "Did you initiate a factory reset before?"
  read -rp "Restore /etc/fstab from /var/etc/fstab? (y/N): " ans
  case "$ans" in
    y|Y )
      echo "Restoring /etc/fstab from /var/etc/fstab."
      cp /var/etc/fstab /etc/fstab
      exit 1
      ;;
    * )
      echo "Not restoring /etc/fstab."
      exit 1
      ;;
  esac
fi
if [ ! -f /etc/crypttab ]; then
  echo "/etc/crypttab not found."
  echo "Did you initiate a factory reset before?"
  read -rp "Restore /etc/crypttab from /var/etc/crypttab? (y/N): " ans
  case "$ans" in
    y|Y )
      echo "Restoring /etc/crypttab from /var/etc/crypttab."
      cp /var/etc/crypttab /etc/crypttab
      exit 1
      ;;
    * )
      echo "Not restoring /etc/crypttab."
      exit 1
      ;;
  esac
fi


# Before reset
# Disclaimer
echo -e "This script ONLY works on Fedora Silverblue and not any other OStree-based systems."
echo -e "Testing has only been done on Fedora Silverblue 42, newer versions may or may not work."
echo -e "Using this script on other Atomic spins may lead to an unbootable system."
echo -e "This script will restore /etc to it's original state."
echo -e "All user accounts and data will be lost."

# Are you sure?
read -rp "Do you want to continue? (y/N): " choice
case "$choice" in
  y|Y ) echo "Proceeding with factory reset...";;
  * ) echo "Aborting."; exit 1;;
esac

# Check if running on Fedora Silverblue
if cat /etc/os-release | grep -q "Silverblue"; then
  echo "Confirmed: Running on Fedora Silverblue."
else
  echo "Error: This script is intended for Fedora Silverblue only."
  exit 1
fi

# Proceed with factory reset
# Backup fstab and crypttab
echo -e "Copying fstab and crypttab from /etc to /var"
cp /etc/fstab /var/etc/fstab
cp /etc/crypttab /var/etc/crypttab
# Run ostree command
echo -e "Resetting all rpm-ostree overrides and overlays and redeploying system..."
ostree admin deploy "$( rpm-ostree status | grep -m 1 -P '^(?=.*fedora:fedora)(?=.*silverblue)' | awk '{$1=$1; print}' )" --no-merge --karg-proc-cmdline
echo -e "Factory reset complete. Please rerun this script after rebooting into the new deployment."