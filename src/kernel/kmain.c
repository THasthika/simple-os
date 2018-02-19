// main.c

#include "common.h"

#include "drivers/screen.h"

void kmain()
{
    screen_enable_cursor();
    screen_clear();

    uint32_t x = 0x254B;

    screen_print_hex(x);
    
    return;
}
