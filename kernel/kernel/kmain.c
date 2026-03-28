#include <stdio.h>
#include <stdint.h>
#include <kernel/gdt.h>
#include <kernel/idt.h>
#include <kernel/tty.h>
#include <kernel/pic.h>
#include <kernel/pmm.h>

void kmain(uint32_t mboot_addr) {
	gdt_init();
	idt_init();
	pic_remap();
	pmm_init(mboot_addr);

	asm volatile ("sti");

	terminal_initialize();

	printf("Hello, kernel World!\n");

	for (;;) {
		asm volatile ("hlt");
	}
}
