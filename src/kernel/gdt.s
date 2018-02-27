	;; gdt_flush

	[global gdt_flush]

gdt_flush:
	mov eax, [esp+4]	; get the parameter from the c code
	lgdt [eax]

	mov ax, 0x10		; 0x10 is the offset from the GDT to the data segment
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	jmp 0x08:.flush
	.flush:
	ret
