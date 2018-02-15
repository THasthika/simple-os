	;;	 print_hex.asm
	;; 
	;; A Routine to print hex of the value in the dx register

print_hex:
	pusha

	mov bx, 0x0
	mov ds, bx

	mov bx, HEX_OUT+0x2
	mov cx, 4

_print_hex_clear_loop:

	cmp cx, 0
	je _print_hex_clear_loop_end
	mov byte [bx], '0'
	sub cx, 1
	add bx, 1
	jmp _print_hex_clear_loop
_print_hex_clear_loop_end:

	mov bx, HEX_OUT+0x5
	
_print_hex_loop:

	cmp dx, 0
	je _print_hex_loop_end
	mov cx, 0xf
	and cx, dx
	cmp cx, 0x9
	jle _print_hex_less_than_ten
	sub cx, 0xa
	add cx, 'A'
	jmp _print_hex_less_than_ten_end
	
_print_hex_less_than_ten:

	add cx, '0'
	
_print_hex_less_than_ten_end:

	mov [bx], cl
	sub bx, 1
	shr dx, 4
	jmp _print_hex_loop

_print_hex_loop_end:

	mov bx, HEX_OUT		;
	call print_string
	
	popa
	ret

HEX_OUT:
	db '0x0000', 0
