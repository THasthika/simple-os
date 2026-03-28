#include <stdio.h>
#include <kernel/gdt.h>
#include <kernel/idt.h>
#include <kernel/tty.h>

void kmain(void) {
	gdt_init();
	idt_init();
	terminal_initialize();

	printf("Hello, kernel World!\n");
}
