	;;;	 print_hex.asm --- 
	;; 
	;; Filename: print_hex.asm
	;; Description: 
	;; Author: Tharindu Hasthika
	;; Maintainer: Tharindu Hasthika 
	;; Created: Thu Feb 15 07:43:27 2018 (+0530)
	;; Version: 
	;; Last-Updated: Thu Feb 15 08:15:55 2018 (+0530)
	;;           By: Tharindu Hasthika
	;;     Update #: 10
	;; URL: 
	;; Keywords: 
	;; Compatibility: 
	;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; 
	;;; Commentary: 
	;; 
	;; A Routine to print hex of the value in the dx register
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

print_hex:
	pusha

	mov bx, 0x0
	mov ds, bx

	mov bx, HEX_OUT+0x2
	mov cx, 4

_print_hex_clear_loop:

	cmp cx, 0
	je _print_hex_clear_loop_end
	mov byte [bx], '0'
	sub cx, 1
	add bx, 1
	jmp _print_hex_clear_loop
_print_hex_clear_loop_end:

	mov bx, HEX_OUT+0x5
	
_print_hex_loop:

	cmp dx, 0
	je _print_hex_loop_end
	mov cx, 0xf
	and cx, dx
	cmp cx, 0x9
	jle _print_hex_less_than_ten
	sub cx, 0xa
	add cx, 'A'
	jmp _print_hex_less_than_ten_end
	
_print_hex_less_than_ten:

	add cx, '0'
	
_print_hex_less_than_ten_end:

	mov [bx], cl
	sub bx, 1
	shr dx, 4
	jmp _print_hex_loop

_print_hex_loop_end:

	mov bx, HEX_OUT		;
	call print_string
	
	popa
	ret

HEX_OUT:
	db '0x0000', 0

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; print_hex.asm ends here
