#!/bin/sh
set -e

OS="$(uname -s)"

echo "Installing simple-os development prerequisites..."

case "$OS" in
  Darwin)
    if ! command -v brew >/dev/null 2>&1; then
      echo "Error: Homebrew not found. Install it from https://brew.sh"
      exit 1
    fi
    brew install i686-elf-gcc i686-elf-binutils qemu xorriso
    ;;
  Linux)
    if command -v apt-get >/dev/null 2>&1; then
      sudo apt-get update
      sudo apt-get install -y gcc-i686-linux-gnu binutils-i686-linux-gnu qemu-system-x86 xorriso
    elif command -v pacman >/dev/null 2>&1; then
      sudo pacman -S --needed i686-elf-gcc i686-elf-binutils qemu-system-x86 xorriso
    elif command -v dnf >/dev/null 2>&1; then
      sudo dnf install -y gcc-i686-elf binutils-i686-elf qemu-system-x86 xorriso
    else
      echo "Error: Unsupported package manager. Install manually: i686-elf cross-compiler, qemu, xorriso"
      exit 1
    fi
    ;;
  *)
    echo "Error: Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "Done. Run ./build.sh to build the kernel."
