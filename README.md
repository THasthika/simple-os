# Simple OS

A minimal x86 operating system kernel built from scratch for learning OS fundamentals.

## What's Implemented

- Multiboot-compliant bootloader (GRUB)
- VGA text-mode terminal driver (80x25, 16 colors)
- Kernel libc (`libk.a`): printf (%c, %s), string ops, abort
- Bootable ISO generation
- QEMU + GDB remote debugging

## Prerequisites

- `i686-elf` cross-compiler toolchain (gcc, ar, as)
- GRUB 2 (`grub-mkrescue`)
- QEMU (`qemu-system-i386`)
- GDB (optional, for debugging)

## Build & Run

```bash
./build.sh          # build libc + kernel
./qemu.sh           # run in QEMU (builds ISO first)
./clean.sh          # remove all artifacts
```

## Project Structure

```
kernel/             # kernel source
  arch/i386/        # x86 boot, TTY driver, VGA, linker script
  kernel/kmain.c    # kernel entry point
libc/               # freestanding C library (libk.a)
scripts/            # cross-compiler config, ISO creation
```

## Next Steps

- [x] GDT (Global Descriptor Table) setup
- [ ] IDT + interrupt/exception handling (ISRs)
- [ ] PIC remapping + hardware interrupts (keyboard, timer)
- [ ] Physical memory manager (bitmap/buddy allocator)
- [ ] Paging / virtual memory
- [ ] Heap allocator (kmalloc/kfree)
- [ ] PS/2 keyboard driver
- [ ] Basic shell / command input
- [ ] Process abstraction + context switching
- [ ] Preemptive scheduler
- [ ] User mode (ring 3) + syscalls
- [ ] VFS + initrd or FAT filesystem
- [ ] ELF loader for user programs
