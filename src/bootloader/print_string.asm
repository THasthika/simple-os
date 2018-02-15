	;; print_string.asm
	;; 
	;; A Routine to print a null terminated string addressed in bx
	;; register

print_string:

	pusha			; put all the registers to the stack
	
	mov ah, 0x0e
	
_print_string_loop:

	cmp byte [bx], 0
	je _print_string_end
	mov al, [bx]
	int 0x10
	add bx, 1
	jmp _print_string_loop
	
_print_string_end:

	popa			; restore all the registers
	ret
