	;; check_a20.asm
	;;
	;; This routine checks if A20 address line is active
	;;
	;; input:
	;;
	;; output:
	;; 	ax = 1 if A20 is active
	;; 	ax = 0 if A20 is not active

check_a20:
	pushf
	push ds
	push es
	push di
	push si

	cli

	xor ax, ax		; ax = 0
	mov es, ax

	not ax			; ax = 0xFFFF
	mov ds, ax

	mov di, 0x0500
	mov si, 0x0510

	mov al, byte [es:di]
	push ax

	mov al, byte [ds:si]
	push ax

	mov byte [es:di], 0x00
	mov byte [ds:si], 0xFF

	cmp byte [es:di], 0xFF

	pop ax
	mov byte [ds:si], al

	pop ax
	mov byte [es:di], al

	mov ax, 0
	je _check_a20_exit

	mov ax, 1

_check_a20_exit:

	pop si
	pop di
	pop es
	pop ds
	popf
	
	ret
