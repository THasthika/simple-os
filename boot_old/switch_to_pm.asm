	;; switch_to_pm.asm
	;;
	
	[bits 16]

switch_to_pm:	

	cli			; clear interrupts

	lgdt [gdt_descriptor]	; load the previously defined gdt

	;; to switch to 32 bit from 16 bit the first bit of cr0
	;; register must be set
	mov eax, cr0		; load the cr0 register to eax
	or eax, 0x1		; set eax first bit
	mov cr0, eax		; put the new cr0 value

	;; to clear the existing pipeline we must far jump
	;; to a new address

	jmp CODE_SEG:init_pm

	[bits 32]

init_pm:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	; update the stack to the top of free space
	mov esp, ebp

	jmp BEGIN_PM		; call a well known label
