.set FLAGS, 	(1<<0 | 1<<1)
.set MAGIC, 	0x1BADB002
.set CHECKSUM, 	-(MAGIC + FLAGS)

.section .multiboot
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .text
.extern kmain
.global _start
_start:
	movl $kernel_stack, %esp
	push %eax
	push %ebx
	call kmain
	cli
hang:
	hlt
	jmp hang

.section .bss
.space 2*1024*1024; # 2 MB
kernel_stack:
