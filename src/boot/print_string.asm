	;; print_string.asm
	;; 
	;; A Routine to print a null terminated string addressed in ds:si
	;; register

print_string:

	pusha			; put all the registers to the stack
	
	.print_string_loop:

	lodsb
	or al, al
	jz .print_string_end
	mov ah, 0x0e
	int 0x10
	jmp .print_string_loop
	
	.print_string_end:
	
	popa
	ret
