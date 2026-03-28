#include <kernel/io.h>

#define PIC1_CMD   0x20
#define PIC1_DATA  0x21
#define PIC2_CMD   0xA0
#define PIC2_DATA  0xA1
#define PIC_EOI    0x20

void pic_remap(void) {
    // ICW1: start initialization
    outb(PIC1_CMD, 0x11);
    io_wait();
    outb(PIC2_CMD, 0x11);
    io_wait();

    // ICW2: interrupt offsets
    outb(PIC1_DATA, 0x20);   // master: IRQ 0-7 → int 32-39
    io_wait();
    outb(PIC2_DATA, 0x28);   // slave: IRQ 8-15 → int 40-47
    io_wait();

    // ICW3: cascade wiring
    outb(PIC1_DATA, 0x04);   // master: slave on IRQ2 (bit 2)
    io_wait();
    outb(PIC2_DATA, 0x02);   // slave: cascade identity 2
    io_wait();

    // ICW4: 8086 mode
    outb(PIC1_DATA, 0x01);
    io_wait();
    outb(PIC2_DATA, 0x01);
    io_wait();

    // Unmask all IRQs (0x00 = all enabled)
    outb(PIC1_DATA, 0x00);
    outb(PIC2_DATA, 0x00);
}

void pic_send_eoi(uint8_t irq) {
    if (irq >= 8)
        outb(PIC2_CMD, PIC_EOI);
    outb(PIC1_CMD, PIC_EOI);
}
