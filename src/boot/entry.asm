	;; entry.asm

	[org 0x0]
	[bits 16]

	;; OEM BLOCK
	db 0x00
	db 0xff
	;; OEM BLOCK

start:
	
	
	times 510 - ($-$$) db 0

	dw 0xAA55		; Boot Signature
