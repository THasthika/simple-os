void printf(char *str)
{
    unsigned short *vmem = (unsigned short*) 0xb8000;

    for (int i = 0; str[i] != '\0'; i++)
        vmem[i] = (vmem[i] & 0xFF00) | str[i];

}

void kmain(void *mboot_struct, unsigned int magic_number)
{
    printf("Hello World");
}
