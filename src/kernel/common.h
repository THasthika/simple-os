#ifndef _COMMON_H
#define _COMMON_H

// typedefs for 32 bit X86
typedef unsigned int uint32_t;
typedef int int32_t;
typedef unsigned short uint16_t;
typedef short int16_t;
typedef unsigned char uint8_t;
typedef char int8_t;

typedef uint32_t size_t;

// io function headers
void outb(uint16_t port, uint8_t value);
uint8_t inb(uint16_t port);

void outw(uint16_t port, uint16_t value);
uint16_t inw(uint16_t port);

void outl(uint16_t port, uint32_t value);
uint32_t inl(uint16_t port);

// util function headers
void* memcpy(void *dest, void *src, size_t n);

uint32_t atoi(char *str);

#endif // _COMMON_H
