#include "../common.h"

#include "screen.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// Attribute byte for our default color scheme
#define WHITE_ON_BLACK 0x0f

// Screen Device I/O ports
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5

/* uint16_t get_cursor(); */
void set_cursor(uint8_t x, uint8_t y);

void put_char_at(char c, uint8_t x, uint8_t y)
{
    
}

void screen_put(char c)
{
    
}

/* int get_screen_offset(int col, int row); */
/* int handle_scrolling(int cursor_offset); */
/* void print_char(char character, int col, int row, char attribute_byte); */

/* void screen_print(char *c) */
/* { */
/*     int i = 0; */
/*     while(c[i] != 0) */
/*     { */
/* 	print_char(message[i++], -1, -1, WHITE_ON_BLACK); */
/*     } */
/* } */

/* void screen_clear() */
/* { */
/*     int row = 0; */
/*     int col = 0; */

/*     for(; row < MAX_ROWS; row++) */
/*     { */
/* 	for(col = 0; col < MAX_COLS; col++) */
/* 	{ */
/* 	    print_char(' ', col, row, WHITE_ON_BLACK); */
/* 	} */
/*     } */

/*     set_cursor(get_screen_offset(0, 0)); */
/* } */

/* /\* Print a character to screen at col, row, or at cursor position *\/ */
/* void print_char(char c, int col, int row, char attribute_byte) */
/* { */
/*     unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS; */

/*     // assume default style if style is not set */
/*     if(!attribute_byte) */
/*     { */
/* 	attribute_byte = WHITE_ON_BLACK; */
/*     } */

/*     // get the video memory offset for the given position */
/*     int offset; */
/*     if(col >= 0 && row >= 0) */
/*     { */
/*     	offset = get_screen_offset(col, row); */
/*     } */
/*     else */
/*     { */
/*     	offset = get_cursor(); */
/*     } */

/*     // if character is a newline, set offset to the end of current row */
/*     if(c == '\n') */
/*     { */
/*     	int rows = offset / (2 * MAX_COLS); */
/*     	offset = get_screen_offset(MAX_COLS - 1, rows); */
/*     } */
/*     else */
/*     { */
/*     	vidmem[offset] = c; */
/*     	vidmem[offset+1] = attribute_byte; */
/*     } */

/*     // update the offset */
/*     offset += 2; */

/*     offset = handle_scrolling(offset); */

/*     set_cursor(offset); */
/* } */


/* int get_screen_offset(int col, int row) */
/* { */
/*     return (row * MAX_COLS + col) * 2; */
/* } */

/* int handle_scrolling(int cursor_offset) */
/* { */
/*     if(cursor_offset < MAX_ROWS*MAX_COLS*2) */
/*     { */
/* 	return cursor_offset; */
/*     } */

/*     int i; */
/*     for(i = 1; i < MAX_ROWS; i++) */
/*     { */
/* 	memory_copy((char *)(get_screen_offset(0, i) + VIDEO_ADDRESS), (char *)(get_screen_offset(0, i-1) + VIDEO_ADDRESS), MAX_COLS * 2); */
/*     } */

/*     char *last_line = (char *)(get_screen_offset(0, MAX_ROWS-1) + VIDEO_ADDRESS); */
/*     for(i = 0; i < MAX_COLS*2; i++) */
/*     { */
/* 	last_line[i] = 0; */
/*     } */

/*     cursor_offset -= 2*MAX_COLS; */

/*     return cursor_offset; */
/* } */

/* uint16_t get_cursor() */
/* { */
/*     // This device uses its control registers as an index */
/*     // to select its internal registers, of which we are */
/*     // interested in: */
/*     // reg 14: which is the high byte of the cursor's offset */
/*     // reg 15: which is the low byte of the cursor's offset */
/*     // Once the internal register has been selected, we may read or */
/*     // write a byte on the data register. */
/*     outb(REG_SCREEN_CTRL, 14); */
/*     uint16_t offset = inb(REG_SCREEN_DATA) << 8; */
/*     outb(REG_SCREEN_CTRL, 15); */
/*     offset += inb(REG_SCREEN_DATA); */
    
/*     return offset*2; */
/* } */

void set_cursor(uint8_t x, uint8_t y)
{
    uint16_t loc = y * MAX_COLS + x;
    outb(REG_SCREEN_CTRL, 14); 	/* tell the VGA controller that we are going to set the cursor high byte */
    outb(REG_SCREEN_DATA, loc >> 8);
    outb(REG_SCREEN_CTRL, 15);	/* tell the VGA controller that we are going to set the cursor low byte */
    outb(REG_SCREEN_DATA, loc);
}
