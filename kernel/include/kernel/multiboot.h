#ifndef MULTIBOOT_HEADER
#define MULTIBOOT_HEADER 1

#include <stdint.h>

struct multiboot_info {
    uint32_t flags;
    uint32_t mem_lower;       // KB of lower memory (below 1MB)
    uint32_t mem_upper;       // KB of upper memory (above 1MB)
    uint32_t boot_device;
    uint32_t cmdline;
    uint32_t mods_count;
    uint32_t mods_addr;
    uint32_t syms[4];
    uint32_t mmap_length;     // total size of memory map buffer
    uint32_t mmap_addr;       // pointer to first mmap entry
} __attribute__((packed));

struct multiboot_mmap_entry {
    uint32_t size;            // size of this entry (minus 4)
    uint32_t addr_low;
    uint32_t addr_high;
    uint32_t len_low;
    uint32_t len_high;
    uint32_t type;            // 1 = usable, everything else = reserved
} __attribute__((packed));

#endif