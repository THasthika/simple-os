#include <stdio.h>
#include <kernel/gdt.h>
#include <kernel/idt.h>
#include <kernel/tty.h>
#include <kernel/pic.h>

void kmain(void) {
	gdt_init();
	idt_init();

	pic_remap();
	asm volatile ("sti");

	terminal_initialize();

	printf("Hello, kernel World!\n");

	for (;;) {
		asm volatile ("hlt");
	}
}
