// main.c

#include "kernel/common.h"
#include "kernel/descriptor_tables.h"

#include "drivers/screen.h"

void kmain()
{
    screen_enable_cursor();
    screen_clear();

    init_descriptor_tables();

    
    
    return;
}
