	;;
	;; bootloader.asm
	;;

	[org 0x7c00]
	[bits 16]

	jmp _start

	%include "bootloader/print.asm"

_start:	
	mov bp, 0x8000		; set base pointer to 0x7c00 + 0x8000 ?
	mov sp, bp		; sp = bp

	mov bx, hello_string
	call print
	
	jmp $

hello_string:
	db "Hello World", 0
	
	times 510 - ($-$$) db 0

	dw 0xAA55		; Boot Signature
	
