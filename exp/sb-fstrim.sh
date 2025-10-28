#!/usr/bin/env bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root." >&2
  exit 1
fi

# Run fstrim
fstrim -v /sysroot
fstrim -v /home
fstrim -v /var