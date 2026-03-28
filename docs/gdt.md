# GDT (Global Descriptor Table)

## Purpose

Tells the CPU about memory segments — what ranges exist, permissions, and privilege levels.
Required for protected mode. GRUB sets up a temporary one; we replace it with our own.

## Our Table (flat model)

All segments cover 0-4GB. Segmentation isn't used for memory protection (that's paging's job) — the GDT is mainly a formality the CPU requires, but the ring levels enforce kernel vs user mode.

| Index | Selector | Name        | Access | Flags | Purpose                      |
|-------|----------|-------------|--------|-------|------------------------------|
| 0     | 0x00     | Null        | 0x00   | 0x0   | Required by CPU, never used  |
| 1     | 0x08     | Kernel Code | 0x9A   | 0xC   | Ring 0, execute/read         |
| 2     | 0x10     | Kernel Data | 0x92   | 0xC   | Ring 0, read/write           |
| 3     | 0x18     | User Code   | 0xFA   | 0xC   | Ring 3, execute/read         |
| 4     | 0x20     | User Data   | 0xF2   | 0xC   | Ring 3, read/write           |

Selector = index * 8 (lower 3 bits encode privilege level and table type).

## Access Byte

```
  7   6  5   4   3   2   1   0
[ P | DPL | S | E | DC| RW| A ]

P   = Present (1 = valid)
DPL = Privilege (0 = kernel, 3 = user)
S   = Type (1 = code/data)
E   = Executable (1 = code, 0 = data)
DC  = Direction/Conforming
RW  = Readable (code) or Writable (data)
A   = Accessed (set by CPU)
```

## Flags Nibble

```
  7   6   5   4
[ G | DB| L | 0 ]

G  = Granularity (1 = limit in 4KB pages)
DB = Size (1 = 32-bit)
L  = Long mode (0 for 32-bit)
```

## Loading

`gdt_init()` populates the table, then `gdt_flush` (assembly) calls `lgdt` and reloads all segment registers. The far jump `ljmp $0x08, $.flush` reloads `cs` (only way to change it).

## Files

- `kernel/arch/i386/gdt.c` — table setup
- `kernel/arch/i386/gdt_flush.S` — lgdt + segment reload
- `kernel/include/kernel/gdt.h` — structs and declarations
