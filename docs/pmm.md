# Physical Memory Manager (PMM)

## Purpose

Tracks which 4KB physical memory frames are free or in use. Provides `pmm_alloc_frame()` and `pmm_free_frame()` for the rest of the kernel.

## Design: Bitmap Allocator

One bit per frame. 1 = used, 0 = free.

```
Frame:  0 1 2 3 4 5 6 7 8 ...
Bitmap: 1 1 1 1 0 0 0 0 0 ...
        ^^^^^^^^
        kernel/reserved
```

- 4GB / 4KB = 1M frames = 128KB bitmap
- Currently capped at MAX_FRAMES (32768 = 128MB)
- Allocation is O(n) scan — fine for now

## Initialization

1. GRUB passes a Multiboot info struct pointer in `ebx` at boot
2. `boot.S` pushes `ebx` as argument to `kmain(uint32_t mboot_addr)`
3. `pmm_init()` parses the Multiboot memory map:
   - Marks all frames as used (bitmap = 0xFF)
   - Walks the memory map, frees frames in usable regions (type == 1)
   - Re-marks frames 0 through `_kernel_end` as used (protects kernel code/data)

## Multiboot Memory Map

GRUB provides a list of memory regions with types:

| Type | Meaning |
|------|---------|
| 1    | Usable RAM |
| 2+   | Reserved (BIOS, ACPI, MMIO, etc.) |

Typical layout:
```
0x00000000 - 0x0009FFFF  usable (640KB lower memory)
0x000A0000 - 0x000FFFFF  reserved (VGA, BIOS ROM)
0x00100000 - 0x03FFFFFF  usable (upper memory, kernel loaded here)
```

## API

```c
void     pmm_init(uint32_t mboot_addr);  // parse memory map, set up bitmap
uint32_t pmm_alloc_frame(void);          // returns physical address of free 4KB frame
void     pmm_free_frame(uint32_t addr);  // marks frame as free
```

`pmm_alloc_frame()` returns 0 on out-of-memory.

## Linker Symbol

`_kernel_end` is defined in `linker.ld` at the end of the `.bss` section. The PMM uses it to know which frames the kernel occupies.

## Files

- `kernel/arch/i386/pmm.c` — bitmap and allocation logic
- `kernel/include/kernel/pmm.h` — API declarations
- `kernel/include/kernel/multiboot.h` — Multiboot info and memory map structs
- `kernel/arch/i386/linker.ld` — `_kernel_end` symbol
- `kernel/arch/i386/boot.S` — passes Multiboot info pointer to kmain
