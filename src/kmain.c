#include "./multiboot.h"

void printf(char *str)
{
    unsigned short *vmem = (unsigned short*) 0xb8000;

    for (int i = 0; str[i] != '\0'; i++)
        vmem[i] = (vmem[i] & 0xFF00) | str[i];

}

void kmain(unsigned int magic_number, unsigned long addr)
{
    multiboot_info_t *mbi;

    mbi = (multiboot_info_t*) addr;

    printf("Hello World");
}
