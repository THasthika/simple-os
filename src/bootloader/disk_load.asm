	;;; disk_load.asm --- 
	;; 
	;; Filename: disk_load.asm
	;; Description: 
	;; Author: Tharindu Hasthika
	;; Maintainer: Tharindu Hasthika
	;; Created: Thu Feb 15 07:56:54 2018 (+0530)
	;; Version: 
	;; Last-Updated: Thu Feb 15 08:36:09 2018 (+0530)
	;;           By: Tharindu Hasthika
	;;     Update #: 21
	;; URL: 
	;; Keywords: 
	;; Compatibility: 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Commentary: 
	;; 
	;; Load 'n' sectors starting from the the 2nd sector from the
	;; beginning of the disk
	;; ARGUMENTS:
	;; dh - number of sectors to read
	;; dl - drive number to read from
	;; [es:bx] - location in memory to load the data
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

disk_load:

	push ax
	push cx
	push dx

	mov ah, 0x02		; set the bios interrupt index
	mov al, dh		; no of sectors to read
	mov ch, 0x00		; sector 0
	mov dh, 0x00		; head 0
	mov cl, 0x02		; start from the 2nd sector

	int 0x13		; call the bios interrupt
	jc _disk_error

	pop dx

	cmp dh, al
	jne _disk_error
	
	pop cx
	pop ax
	ret

_disk_error:

	mov bx, 0x00
	mov ds, bx
	
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG:	db "Disk read error!", 0

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; disk_load.asm ends here
