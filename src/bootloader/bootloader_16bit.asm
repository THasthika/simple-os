	;;; bootloader.asm --- 
	;; 
	;; Filename: bootloader.asm
	;; Description: 
	;; Author: Tharindu Hasthika
	;; Maintainer: Tharindu Hasthika
	;; Created: Thu Feb 15 07:37:43 2018 (+0530)
	;; Version: 
	;; Last-Updated: Thu Feb 15 09:08:46 2018 (+0530)
	;;           By: Tharindu Hasthika
	;;     Update #: 68
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

	[org 0x7c00]
	[bits 16]

	jmp _start

	%include "print_string.asm"
	%include "print_hex.asm"
	%include "disk_load.asm"
	
_start:
	mov [BOOT_DRIVE], dl
	
	;; set the stack segment and initialize a stack
	;; mov bx, 0x8000
	;; mov ss, bx
	mov bp, 0x8000		; set base pointer to 0xffff [physical location 0x8000 * 16 + 0xf000 = 0x8f000]
	mov sp, bp		; sp = bp

	;; mov ah, 0x2
	;; mov al, 5		; number of sectors to read
	;; mov ch, 0		; cylinder number
	;; mov cl, 2		; sector number (starts from 1)
	;; mov dh, 0		; head count (starts from 0)
	;; mov dl, 0		; drive number

	mov bx, 0x00
	mov es, bx
	mov bx, 0x9000
	
	mov dl, [BOOT_DRIVE]
	mov dh, 5
	call disk_load

	mov bx, 0x9000
	call print_string

	jmp $

BOOT_DRIVE:	db 0
	
	times 510 - ($-$$) db 0

	dw 0xAA55		; Boot Signature

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; bootloader.asm ends here
