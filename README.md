# Simple OS

A minimal x86 operating system kernel built from scratch for learning OS fundamentals.

## What's Implemented

- Multiboot-compliant bootloader (GRUB)
- GDT (Global Descriptor Table) — flat model, kernel + user segments
- IDT (Interrupt Descriptor Table) — 32 CPU exception handlers
- PIC remapping — hardware IRQs on interrupts 32-47
- Timer (PIT) and keyboard (PS/2) interrupt handling
- VGA text-mode terminal driver (80x25, 16 colors)
- Kernel libc (`libk.a`): printf (%c, %s, %d), string ops, abort
- QEMU direct kernel boot + GDB remote debugging

## Prerequisites

- `i686-elf` cross-compiler toolchain (gcc, ar, as)
- QEMU (`qemu-system-i386`)
- GDB (optional, for debugging)

Run `./prereq.sh` to install dependencies (macOS + Linux).

## Build & Run

```bash
./prereq.sh         # install toolchain + QEMU
./build.sh          # build libc + kernel
./qemu.sh           # run in QEMU
./clean.sh          # remove all artifacts
```

## Project Structure

```
kernel/             # kernel source
  arch/i386/        # x86 boot, GDT, IDT, ISRs, TTY, VGA
  kernel/kmain.c    # kernel entry point
  include/kernel/   # kernel headers
libc/               # freestanding C library (libk.a)
scripts/            # cross-compiler config
docs/               # architecture and design notes
```

## Next Steps

- [x] GDT (Global Descriptor Table) setup
- [x] IDT + interrupt/exception handling (ISRs)
- [x] PIC remapping + hardware interrupts (keyboard, timer)
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
