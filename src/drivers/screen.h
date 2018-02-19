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
#define SCREEN_COLOR_LIGHT_GREEN    0xa
#define SCREEN_COLOR_LIGHT_CYAN     0xb
#define SCREEN_COLOR_LIGHT_RED      0xc
#define SCREEN_COLOR_LIGHT_MAGENTA  0xd
#define SCREEN_COLOR_LIGHT_BROWN    0xe
#define SCREEN_COLOR_WHITE          0xf

/* clear the monitor screen */
void screen_clear();

void screen_put(char c);

void screen_print(char *c);

#endif // _DRIVERS_SCREEN
