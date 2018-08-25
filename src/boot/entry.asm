	;; entry.asm

	[org 0x7c00]
	[bits 16]

	KERNEL_OFFSET equ 0x1000 ; memory offset of the kernel loading location

	mov [BOOT_DRIVE], dl

	mov bp, 0x9000
	mov sp, bp

	mov si, REAL_MODE_MSG
	call print_string

	call load_kernel

; 	jmp switch_to_pm

	%include "print_string.asm"
	%include "disk_load.asm"
	%include "check_a20.asm"
	%include "gdt.asm"
	%include "print_string_pm.asm"
	%include "switch_to_pm.asm"

	[bits 16]
load_kernel:
	
; 	mov si, LOAD_KERNEL_MSG
; 	call print_string

; 	mov dx, 0x0
; 	mov es, dx

; 	mov bx, KERNEL_OFFSET
; 	mov dh, 15
; 	mov dl, [BOOT_DRIVE]
; 	call disk_load

; 	or ax, ax
; 	jz .error

; 	jmp .done

; 	.error:
; 	mov si, DISK_LOAD_ERROR
; 	call print_string

	; jmp $

	; .done:
	; ret

	[bits 32]
	
BEGIN_PM:
	mov esi, PROT_MODE_MSG
	call print_string_pm

	; jmp KERNEL_OFFSET
	
	jmp $
	
BOOT_DRIVE:	db 0
LOAD_KERNEL_MSG:	db 'Loading the Kernel...', 0
REAL_MODE_MSG:	db 'In Real Mode!', 0
PROT_MODE_MSG:	db 'In Prot Mode!', 0
DISK_LOAD_ERROR:	db 'Disk Load Error!', 0

	times 440 - ($-$$) db 0

	dw 0x12BB
	;; 16 byte partiton structure x 4
	
	times 510 - ($-$$) db 0

	dw 0xAA55		; Boot Signature