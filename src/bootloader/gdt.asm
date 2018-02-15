	;;; gdt.asm --- 
	;; 
	;; Filename: gdt.asm
	;; Description: 
	;; Author: Tharindu Hasthika
	;; Maintainer: 
	;; Created: Thu Feb 15 09:53:00 2018 (+0530)
	;; Version: 
	;; Last-Updated: Thu Feb 15 12:34:50 2018 (+0530)
	;;           By: Tharindu Hasthika
	;;     Update #: 23
	;; URL: 
	;; Keywords: 
	;; Compatibility: 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Commentary: 
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
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; gdt.asm ends here
