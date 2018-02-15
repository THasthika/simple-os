	;;; switch_to_pm.asm --- 
	;; 
	;; Filename: switch_to_pm.asm
	;; Description: 
	;; Author: Tharindu Hasthika
	;; Maintainer: 
	;; Created: Thu Feb 15 13:00:23 2018 (+0530)
	;; Version: 
	;; Last-Updated: Thu Feb 15 13:19:19 2018 (+0530)
	;;           By: Tharindu Hasthika
	;;     Update #: 8
	;; URL: 
	;; Keywords: 
	;; Compatibility: 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Commentary: 
	;; 
	;; 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Change Log:
	;; 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;; This program is free software; you can redistribute it and/or
	;; modify it under the terms of the GNU General Public License as
	;; published by the Free Software Foundation; either version 3, or
	;; (at your option) any later version.
	;; 
	;; This program is distributed in the hope that it will be useful,
	;; but WITHOUT ANY WARRANTY; without even the implied warranty of
	;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	;; General Public License for more details.
	;; 
	;; You should have received a copy of the GNU General Public License
	;; along with this program; see the file COPYING.  If not, write to
	;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
	;; Floor, Boston, MA 02110-1301, USA.
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Code:

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

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; switch_to_pm.asm ends here
