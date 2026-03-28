# Boot Sequence

## Flow

```
GRUB → boot.S (_start) → kmain() → gdt_init() → idt_init() → ...
```

## boot.S

1. GRUB loads the kernel ELF at 1MB (0x100000) via Multiboot
2. `_start` sets up a 16KB stack
3. Calls `_init` (global constructors)
4. Jumps to `kmain()`
5. If kmain returns: disables interrupts (`cli`) and halts (`hlt` loop)

## Multiboot Header

Located at the start of the `.multiboot` section. Contains:
- Magic: `0x1BADB002`
- Flags: page-aligned modules
- Checksum: `-(magic + flags)`

GRUB scans the first 8KB of the kernel for this header to verify it's Multiboot-compliant.

## Memory Layout (linker.ld)

```
0x00100000 (1MB)  .multiboot    Multiboot header
                  .text         Code
                  .rodata       Read-only data
                  .data         Initialized data
                  .bss          Uninitialized data (zeroed)
```

All sections are 4KB page-aligned. Entry point is `_start` in boot.S.

## QEMU Boot

Currently booting with `qemu-system-i386 -kernel kernel.bin`, which loads the ELF directly without needing a GRUB ISO.
