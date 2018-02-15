	;;; print_string.asm --- 
	;; 
	;; Filename: print_string.asm
	;; Description: 
	;; Author: Tharindu Hasthika
	;; Maintainer: Tharindu Hasthika
	;; Created: Thu Feb 15 07:46:05 2018 (+0530)
	;; Version: 
	;; Last-Updated: Thu Feb 15 07:51:33 2018 (+0530)
	;;           By: Tharindu Hasthika
	;;     Update #: 4
	;; URL: 
	;; Keywords: 
	;; Compatibility: 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Commentary: 
	;; 
	;; A Routine to print a null terminated string addressed in bx
	;; register
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

print_string:

	pusha			; put all the registers to the stack
	
	mov ah, 0x0e
	
_print_string_loop:

	cmp byte [bx], 0
	je _print_string_end
	mov al, [bx]
	int 0x10
	add bx, 1
	jmp _print_string_loop
	
_print_string_end:

	popa			; restore all the registers
	ret

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; print_string.asm ends here
