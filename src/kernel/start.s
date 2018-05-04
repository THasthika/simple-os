	;;
	;; start.s -- Kernel start location. Also defines multiboot header.
	;; Based on Bran's kernel development tutorial file start.asm
	;;
	[bits 32]

	[global start]        			; Kernel entry point.
	[extern kmain]        			; This is the entry point of our C code
	
start:
	;; Execute the kernel:
	cli                			; Disable interrupts.
	call kmain           			; call our main() function.
	jmp $              			; Enter an infinite loop, to stop the processor