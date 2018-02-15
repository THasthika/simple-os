	;; gdt.asm 
	;; 
	;; This file defines a flat memory layout for the 32bit
	;; protected mode that is needed in the Global Descriptor Table
	;;
	;;
	;; Segment Descriptor Structure (64 bits or 8 bytes)
	;; 00 - 15 	:	Segment Limit (16 bits)
	;; 00 - 15	:	Base Address (16 bits)
	;; 16 - 23	:	Base Address (8 bits)
	;; 00 - 08	:	1st Flag Set (high 4 bits), type flags (low 4 bits)
	;; 00 - 08	:	2nd Flag Set (high 4 bits), Segment Limit (low 4 bits)
	;; 24 - 31	:	Base Address (8 bits)
	;;
	;; 
	;; The Global Driscriptor Table needs the first entry to be a null
	;; entry.
	;; 

gdt_start:

gdt_null:			; The mandatory null descriptor
	dd 0x0			; dd mean define double word (4 bytes | 2 * 16 bits)
	dd 0x0

gdt_code:			; The Code Segment Descriptor
	;; base=0x0, limit=0xfffff
	;; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001b
	;; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
	;; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b

	dw 0xffff		; Limit (bits 00 - 15)
	dw 0x0			; Base (bits 00 - 15)
	db 0x0			; Base (bits 16 - 23)
	db 10011010b		; 1st flags, type flags
	db 11001111b		; 2nd flags, Limit (bits 16 - 19)
	db 0x0			; Base (bits 24 - 31)

gdt_data:			; The Data Segment Descriptor
	;; This is the same as the Code Segment Descriptor
	;; except for the type flags
	;; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
	dw 0xffff		; Limit (bits 00 - 15)
	dw 0x0			; Base (bits 00 - 15)
	db 0x0			; Base (bits 16 - 23)
	db 10010010b		; 1st flags, type flags
	db 11001111b		; 2nd flags, Limit (bits 16 -19)
	db 0x0			; Base (bits 24 - 31)

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

	CODE_SEG equ gdt_code - gdt_start
	DATA_SEG equ gdt_data - gdt_start
