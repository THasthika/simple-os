	[org 0x7c00]
	[bits 16]

	jmp _start

	%include "print_string.asm"
	%include "print_hex.asm"
	%include "disk_load.asm"
	
_start:
	mov [BOOT_DRIVE], dl
	
	;; set the stack segment and initialize a stack
	;; mov bx, 0x8000
	;; mov ss, bx
	mov bp, 0x8000		; set base pointer to 0xffff [physical location 0x8000 * 16 + 0xf000 = 0x8f000]
	mov sp, bp		; sp = bp

	;; mov ah, 0x2
	;; mov al, 5		; number of sectors to read
	;; mov ch, 0		; cylinder number
	;; mov cl, 2		; sector number (starts from 1)
	;; mov dh, 0		; head count (starts from 0)
	;; mov dl, 0		; drive number

	mov bx, 0x00
	mov es, bx
	mov bx, 0x9000
	
	mov dl, [BOOT_DRIVE]
	mov dh, 5
	call disk_load

	mov bx, 0x9000
	call print_string

	jmp $

BOOT_DRIVE:	db 0
	
	times 510 - ($-$$) db 0

	dw 0xAA55		; Boot Signature
