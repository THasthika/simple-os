#include "kernel/common.h"

#include "screen.h"

#define MAX_ROWS 25
#define MAX_COLS 80

#define DEFAULT_FOREGROUND SCREEN_COLOR_WHITE
#define DEFAULT_BACKGROUND SCREEN_COLOR_BLACK

// Screen Device I/O ports
#define REG_CTRL 0x3D4
#define REG_DATA 0x3D5

/* uint16_t get_cursor(); */

static void enable_cursor(uint8_t cursor_start, uint8_t cursor_end);
static void disable_cursor();
void set_cursor();
void handle_scrolling();

uint16_t get_attribute(uint8_t foreground, uint8_t background);

const uint16_t* VIDEO_ADDRESS = (uint16_t*) 0xB8000;

static uint8_t g_cursor_x = 0, g_cursor_y = 0;
static uint16_t g_attribute = ((DEFAULT_BACKGROUND << 4) | (DEFAULT_FOREGROUND & 0xF)) << 8;

void screen_clear()
{
    
    uint16_t *vid_addr = (uint16_t*) VIDEO_ADDRESS;

    uint16_t vdata = 0x20 | g_attribute;

    int i, j;

    for(i = 0; i < MAX_ROWS; i++)
    {
	for(j = 0; j < MAX_COLS; j++)
    	{
    	    *vid_addr = vdata;
    	    vid_addr += 1;
    	}
    }

    g_cursor_x = g_cursor_y = 0;
    set_cursor();

    return;
}

void screen_put(char c)
{
    uint16_t *vid_addr;

    if(c == 0x08 && g_cursor_x)
    {
	g_cursor_x--;
    }
    else if(c == 0x09)
    {
	// handle tab s.t. when pressed increment x axis by 8
	// but only to a position divisible by 8
	g_cursor_x = (g_cursor_x + 8) & ~(8-1);
    }
    else if(c == '\r')
    {
	g_cursor_x = 0;
    }
    else if(c == '\n')
    {
	g_cursor_x = 0;
	g_cursor_y++;
    }
    else
    {
	vid_addr = (uint16_t*) (VIDEO_ADDRESS + (g_cursor_y * MAX_COLS + g_cursor_x));
	*vid_addr = c | g_attribute;
	g_cursor_x++;
    }

    if(g_cursor_x > MAX_COLS)
    {
    	g_cursor_x = 0;
    	g_cursor_y++;
    }

    handle_scrolling();

    set_cursor();
}

void screen_print(char *c)
{
    while(*c != 0)
	screen_put(*c++);
}

void screen_print_hex(uint32_t n)
{
    char *out = "0x00000000\n";
    char x;
    for(int i = 9; i > 1 && n > 0; i--)
    {
	x = n & 0xf;
	if(x > 9)
	    out[i] = (x - 10) + 'A';
	else
	    out[i] += x;
	n = (n >> 4);
    }
    screen_print(out);
}

void screen_enable_cursor()
{
    enable_cursor(14, 15);
}

void screen_disable_cursor()
{
    disable_cursor();
}

void handle_scrolling()
{
    if(g_cursor_y < MAX_ROWS) return;

    uint16_t *vid_addr = (uint16_t *)VIDEO_ADDRESS;
    uint8_t y = 0;
    for(; y < MAX_ROWS-1; y++)
    {
	memcpy(vid_addr+(y*MAX_COLS), vid_addr+((y+1)*MAX_COLS), MAX_COLS*2);
    }

    uint16_t blank = 0x20 | g_attribute;

    vid_addr = (uint16_t *)(VIDEO_ADDRESS + (g_cursor_y - 1) * MAX_COLS);

    for(y=0; y < MAX_COLS; y++)
    {
	*(vid_addr+y) = blank;
    }

    g_cursor_y--;

    return;
}

void screen_set_foreground(uint8_t color)
{
    uint16_t attr = ((g_attribute >> 8) & 0xF0) | (color & 0x0F);
    g_attribute = attr << 8;
}

void screen_set_background(uint8_t color)
{
    uint16_t attr = ((g_attribute >> 8) & 0x0F) | (color & 0xF0);
    g_attribute = attr << 8;
}

static void enable_cursor(uint8_t cursor_start, uint8_t cursor_end)
{
    outb(REG_CTRL, 0x0A);
    outb(REG_DATA, (inb(REG_DATA) & 0xC0) | cursor_start);
    outb(REG_CTRL, 0x0B);
    outb(REG_DATA, (inb(0x3E0) & 0xE0) | cursor_end);
}

static void disable_cursor()
{
    outb(REG_CTRL, 0x0A);
    outb(REG_DATA, 0x20);
}

void set_cursor()
{
    uint16_t loc = g_cursor_y * MAX_COLS + g_cursor_x;
    outb(REG_CTRL, 0x0F);	/* tell the VGA controller that we are going to set the cursor low byte */
    outb(REG_DATA, (loc & 0xFF));
    outb(REG_CTRL, 0x0E); 	/* tell the VGA controller that we are going to set the cursor high byte */
    outb(REG_DATA, ((loc >> 8) & 0xFF));
}
