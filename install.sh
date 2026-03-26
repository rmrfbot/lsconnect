#!/usr/bin/env bash

set -e

PROGRAM_NAME="lsconnect"
INSTALL_PATH="/usr/local/bin/$PROGRAM_NAME"
SCRIPT_SOURCE="$(dirname "$0")/$PROGRAM_NAME.sh"

echo "== lsconnect installer =="

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this installer with sudo."
  exit 1
fi

# Check NetworkManager
if ! command -v nmcli >/dev/null 2>&1; then
  echo "NetworkManager (nmcli) not found."
  echo "➡ Installing NetworkManager..."
  apt update
  apt install -y network-manager
fi

# Verify source script exists
if [ ! -f "$SCRIPT_SOURCE" ]; then
  echo "$PROGRAM_NAME.sh not found in current directory."
  exit 1
fi

# Copy script to install location
echo "➡ Installing $PROGRAM_NAME to $INSTALL_PATH"
cp "$SCRIPT_SOURCE" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "Installation complete!"
echo
echo "You can now run:"
echo "  sudo $PROGRAM_NAME"
echo
echo "To uninstall later, run the provided uninstall.sh script."
