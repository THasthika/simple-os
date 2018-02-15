	;; disk_load.asm 
	;; 
	;; Load 'n' sectors starting from the the 2nd sector from the
	;; beginning of the disk
	;; ARGUMENTS:
	;; dh - number of sectors to read
	;; dl - drive number to read from
	;; [es:bx] - location in memory to load the data
	;; 

disk_load:

	push ax
	push cx
	push dx

	mov ah, 0x02		; set the bios interrupt index
	mov al, dh		; no of sectors to read
	mov ch, 0x00		; sector 0
	mov dh, 0x00		; head 0
	mov cl, 0x02		; start from the 2nd sector

	int 0x13		; call the bios interrupt
	jc _disk_error

	pop dx

	cmp dh, al
	jne _disk_error
	
	pop cx
	pop ax
	ret

_disk_error:

	mov bx, 0x00
	mov ds, bx
	
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG:	db "Disk read error!", 0
