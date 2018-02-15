	;; a routine to print to screen with int 10 BIOS
	;; bx - starting address of the null terminated string

print_string:

	pusha

	mov dx, 0x0
	mov ds, dx
	
	mov ah, 0x0e
	
_print_string_loop:

	cmp byte [bx], 0
	je _print_string_end
	mov al, [bx]
	int 0x10
	add bx, 1
	jmp _print_string_loop
	
_print_string_end:

	popa
	ret
