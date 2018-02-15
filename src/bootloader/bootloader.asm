	;;
	;; bootloader.asm
	;;

	[org 0x7c00]
	[bits 16]

	jmp _start

	%include "print_string.asm"
	%include "print_hex.asm"
	
_start:
	mov bx, 0x9000
	mov ss, bx
	mov bp, 0xffff		; set base pointer to 0xffff [physical location 0xe000 * 16 + 0xffff = 0xeffff]
	mov sp, bp		; sp = bp

	mov ah, 0x2
	mov al, 1		; number of sectors to read
	mov ch, 0		; cylinder number
	mov cl, 1		; sector number (starts from 1)
	mov dh, 0		; head count (starts from 0)
	mov dl, 0		; drive number

	;; loaded to [es:bx]
	mov bx, 0x9000
	mov es, bx
	mov bx, 0x1000

	int 0x13

	jc disk_error

	cmp al, 1
	jne disk_error

	mov dx, es
	mov ds, dx
	mov dx, [es:0x1000]
	call print_hex

	jmp $

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string

	jmp $

	;; mov bx, HEX_OUT
	;; call print_string

	;; mov dx, 0x1
	;; call print_hex

DISK_ERROR_MSG:	db "Disk error!", 0
	
	times 510 - ($-$$) db 0

	dw 0xAA55		; Boot Signature
	
