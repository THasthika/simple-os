/* 

main.ld - linker script for the kernel

 */

ENTRY(start)			/* starting label in the code */
SECTIONS
{
	.text 0x100000:		/* start the text section at the 1MB mark of the RAM */
	{
		code = .;
		_code = .;
		__code = .;
		*(.text)
		. = ALIGN(4096);
	}

	.data :
	{
		data = .;
		_data = .;
		__data = .;
		*(.data)
		*(.rodata)
		. = ALIGN(4096);
	}

	.bss :
	{
		bss = .;
		_bss = .;
		__bss = .;
		*(.bss)
		. = ALIGN(4096);
	}

	end = .;
	_end = .;
	__end = .;
}
