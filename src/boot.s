.set FLAGS, 	(1<<0 | 1<<1)
.set MAGIC, 	0x1BADB002
.set CHECKSUM, 	-(MAGIC + FLAGS)

.section .multiboot
.align	4
.long 	MAGIC
.long 	FLAGS
.long 	CHECKSUM

.section .text
.extern kmain
.global _start
_start:
	movl $kernel_stack, %esp
	push %ebx		/* Multiboot Information Structure */
	push %eax		/* Magic Number */
	call kmain
	cli
hang:
	hlt
	jmp hang

.section .bss
.space 2*1024*1024; # 2 MB
kernel_stack:
