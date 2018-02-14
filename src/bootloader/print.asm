	;; a routine to print to screen with int 10 BIOS
print:
	pusha
	mov ah, 0x0e
_print_string_loop:
	cmp word [bx], 0
	je _print_string_end
	mov al, [bx]
	int 0x10
	add bx, 0x1
	jmp _print_string_loop
_print_string_end:
	popa
	ret
