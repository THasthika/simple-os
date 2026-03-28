#ifndef PIC_HEADER
#define PIC_HEADER 1

#include <stdint.h>

void pic_remap(void);
void pic_send_eoi(uint8_t irq);

#endif