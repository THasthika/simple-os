#ifndef _DRIVERS_SCREEN
#define _DRIVERS_SCREEN

#define SCREEN_COLOR_BLACK          0x0
#define SCREEN_COLOR_BLUE           0x1
#define SCREEN_COLOR_GREEN          0x2
#define SCREEN_COLOR_CYAN           0x3
#define SCREEN_COLOR_RED            0x4
#define SCREEN_COLOR_MAGENTA        0x5
#define SCREEN_COLOR_BROWN          0x6
#define SCREEN_COLOR_LIGHT_GREY     0x7
#define SCREEN_COLOR_DARK_GREY      0x8
#define SCREEN_COLOR_LIGHT_BLUE     0x9
#define SCREEN_COLOR_LIGHT_GREEN    0xA
#define SCREEN_COLOR_LIGHT_CYAN     0xB
#define SCREEN_COLOR_LIGHT_RED      0xC
#define SCREEN_COLOR_LIGHT_MAGENTA  0xD
#define SCREEN_COLOR_LIGHT_BROWN    0xE
#define SCREEN_COLOR_WHITE          0xF

/* clear the monitor screen */
void screen_clear();
void screen_put(char c);
void screen_print(char *c);
void screen_print_hex(uint32_t n);

void screen_set_foreground(uint8_t color);
void screen_set_background(uint8_t color);

/* cursor control */
void screen_enable_cursor();
void screen_disable_cursor();

#endif // _DRIVERS_SCREEN
