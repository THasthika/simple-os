#include <kernel/gdt.h>

static struct gdt_entry gdt[5];
static struct gdt_ptr   gdtp;

extern void gdt_flush(uint32_t);

static void gdt_set_entry(int i, uint32_t base, uint32_t limit,
                          uint8_t access, uint8_t flags) {
    gdt[i].base_low    = base & 0xFFFF;
    gdt[i].base_middle = (base >> 16) & 0xFF;
    gdt[i].base_high   = (base >> 24) & 0xFF;
    gdt[i].limit_low   = limit & 0xFFFF;
    gdt[i].granularity = ((limit >> 16) & 0x0F) | (flags << 4);
    gdt[i].access      = access;
}

void gdt_init(void) {
    gdtp.limit = sizeof(gdt) - 1;
    gdtp.base  = (uint32_t)&gdt;

    gdt_set_entry(0, 0, 0,       0x00, 0x0);  // null
    gdt_set_entry(1, 0, 0xFFFFF, 0x9A, 0xC);  // kernel code
    gdt_set_entry(2, 0, 0xFFFFF, 0x92, 0xC);  // kernel data
    gdt_set_entry(3, 0, 0xFFFFF, 0xFA, 0xC);  // user code
    gdt_set_entry(4, 0, 0xFFFFF, 0xF2, 0xC);  // user data

    gdt_flush((uint32_t)&gdtp);
}