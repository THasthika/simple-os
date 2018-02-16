	;; disk_load.asm 
	;; 
	;; Load 'n' sectors starting from the the 2nd sector from the
	;; beginning of the disk
	;; input:
	;; 	dh - number of sectors to read
	;; 	dl - drive number to read from
	;; 	[es:bx] - location in memory to load the data
	;;
	;; output:
	;; 	ax - loading status (1 - success, 0 - failure)
	;; 

disk_load:

	push cx
	push dx

	mov ah, 0x02		; set the bios interrupt index
	mov al, dh		; no of sectors to read
	mov ch, 0x00		; sector 0
	mov dh, 0x00		; head 0
	mov cl, 0x02		; start from the 2nd sector

	int 0x13		; call the bios interrupt
	jc .error01

	pop dx

	cmp dh, al
	jne .error02
	
	pop cx

	mov ax, 1
	
	ret

	.error01:
	pop dx

	.error02:
	pop cx
	mov ax, 0
	ret
