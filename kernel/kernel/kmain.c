#include <stdio.h>
#include <kernel/gdt.h>

#include <kernel/tty.h>

void kmain(void) {
	gdt_init();
	terminal_initialize();
	printf("Hello, kernel World!\n");
}
