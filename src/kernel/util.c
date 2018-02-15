/* util.c
   general purpose functions for the operating system
 */
#include "util.h"

/*
  copies n number of bytes from source to destination
*/
void memory_copy(char *source, char *dest, int n)
{
    int i;
    for(i = 0; i < n; i++)
    {
	*(dest+i) = *(source+i);
    }
}
