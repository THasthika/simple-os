/* **************************************************************
 * 
 * common.c
 *
 * Common functions needed by the OS
 * 
 * ************************************************************** */

#include "common.h"

void outb(uint16_t port, uint8_t value)
{
    asm volatile ("outb %1, %0" : : "dN" (port), "a" (value));
}

uint8_t inb(uint16_t port)
{
    uint8_t ret;
    asm volatile ("inb %1, %0" : "=a" (ret) : "dN" (port));
    return ret;
}

void outw(uint16_t port, uint16_t value)
{
    asm volatile ("outw %1, %0" : : "dN" (port), "a" (value));
}

uint16_t inw(uint16_t port)
{
    uint16_t ret;
    asm volatile ("inw %1, %0" : "=a" (ret) : "dN" (port));
    return ret;
}

void outl(uint16_t port, uint32_t value)
{
    asm volatile ("outl %1, %0" : : "dN" (port), "a" (value));
}

uint32_t inl(uint16_t port)
{
    uint32_t ret;
    asm volatile ("inl %1, %0" : "=a" (ret) : "dN" (port));
    return ret;
}

void* memcpy(void *dest, void *src, size_t n)
{
    int i;
    char *csrc = (char *)src;
    char *cdest = (char *)dest;
    for(i = 0; i < n; i++)
    {
	*(cdest+i) = *(csrc+i);
    }
    return dest;
}

uint32_t atoi(char *str)
{
    uint32_t ret = 0;

    while(*str >= '0' && *str <= '9')
    {
	ret = (uint32_t)((ret * 10) + (str - '0'));
    }

    return ret;
}
