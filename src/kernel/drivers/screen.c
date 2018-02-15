#include "../io.h"

#include "screen.h"

int get_screen_offset(int col, int row);
int handle_scrolling(int offset);

int get_cursor();
void set_cursor(int offset);

void print_char(char character, int col, int row, char attribute_byte);


/* Print a character to screen at col, row, or at cursor position */
void print_char(char character, int col, int row, char attribute_byte)
{
    unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

    // assume default style if style is not set
    if(!attribute_byte)
    {
	attribute_byte = WHITE_ON_BLACK;
    }

    // get the video memory offset for the given position
    int offset;
    if(col >= 0 && row >= 0)
    {
	offset = get_screen_offset(col, row);
    }
    else
    {
	offset = get_cursor();
    }

    // if character is a newline, set offset to the end of current row
    if(character == '\n')
    {
	int rows = offset / (2 * MAX_COLS);
	offset = get_screen_offset(MAX_COLS - 1, rows);
    }
    else
    {
	vidmem[offset] = character;
	vidmem[offset+1] = attribute_byte;
    }

    // update the offset
    offset += 2;

    offset = handle_scrolling(offset);

    set_cursor(offset);
}


int get_screen_offset(int col, int row)
{
    return (row * MAX_COLS + col) << 2;
}

int handle_scrolling(int offset)
{

    return offset;
}

int get_cursor()
{
    // This device uses its control registers as an index
    // to select its internal registers, of which we are
    // interested in:
    // reg 14: which is the high byte of the cursor's offset
    // reg 15: which is the low byte of the cursor's offset
    // Once the internal register has been selected, we may read or
    // write a byte on the data register.
    
}

void set_cursor(int offset)
{

    
}
