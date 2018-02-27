#include "kernel/common.h"

#include "descriptor_tables.h"

#define IDT_ENTRIES_COUNT 256

struct gdt_entry_struct
{
    uint16_t limit_low;
    uint16_t base_low;
    uint8_t base_middle;
    uint8_t access;
    uint8_t granularity;
    uint8_t base_high;
} __attribute__((packed));

typedef struct gdt_entry_struct gdt_entry_t;

struct gdt_ptr_struct
{
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));

typedef struct gdt_ptr_struct gdt_ptr_t;

struct idt_entry_struct
{
    uint16_t base_low;
    uint16_t selector;
    uint8_t always0;
    uint8_t flags;
    uint16_t base_high;
} __attribute__((packed));

typedef struct idt_entry_struct idt_entry_t;

struct idt_ptr_struct
{
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));

typedef struct idt_ptr_struct idt_ptr_t;

extern void gdt_flush(uint32_t);

static void init_gdt();
static void gdt_set_gate(int32_t, uint32_t, uint32_t, uint8_t, uint8_t);

extern void idt_flush(uint32_t);

static void init_idt();
static void idt_set_gate(uint8_t, uint32_t, uint16_t, uint8_t);

extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

gdt_entry_t gdt_entries[5];
gdt_ptr_t gdt_ptr;

idt_entry_t idt_entries[IDT_ENTRIES_COUNT];
idt_ptr_t idt_ptr;

void init_descriptor_tables()
{
    init_gdt();
    init_idt();
}

static void init_gdt()
{
    gdt_ptr.limit = (sizeof(gdt_entry_t) * 5) - 1;
    gdt_ptr.base = (uint32_t)&gdt_entries;

    gdt_set_gate(0, 0, 0, 0, 0);		/* Null Segment */
    gdt_set_gate(1, 0, 0xFFFFFFFF, 0x9A, 0xCF); /* Code Segment */
    gdt_set_gate(2, 0, 0xFFFFFFFF, 0x92, 0xCF); /* Data Segment */
    gdt_set_gate(3, 0, 0xFFFFFFFF, 0xFA, 0xCF); /* User Mode Code Segment */
    gdt_set_gate(4, 0, 0xFFFFFFFF, 0xF2, 0xCF); /* User Mode Data Segment */

    gdt_flush((uint32_t)&gdt_ptr);
}

static void init_idt()
{
    idt_ptr.limit = (sizeof(idt_entry_t) * IDT_ENTRIES_COUNT) - 1;
    idt_ptr.base = (uint32_t)&idt_entries;

    memset(&idt_entries, 0, sizeof(idt_entry_t)*IDT_ENTRIES_COUNT);
}

static void gdt_set_gate(int32_t num, uint32_t base, uint32_t limit, uint8_t access, uint8_t gran)
{
    gdt_entries[num].base_low = (base & 0xFFFF);
    gdt_entries[num].base_middle = (base >> 16) & 0xFF;
    gdt_entries[num].base_high = (base >> 24) & 0xFF;

    gdt_entries[num].limit_low = (limit & 0xFFFF);
    gdt_entries[num].granularity = (limit >> 16) & 0x0F;

    gdt_entries[num].granularity |= gran & 0xF0;
    gdt_entries[num].access = access;
}
