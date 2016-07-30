#!/usr/bin/env python
#Author sajith shetty
#usage: ./compile.py filenamewithoutextension
import os
import sys

print "[+]Compiling in progress..."

try:

	print "[+]Assembling in Nasm..."
	
	t = ("nasm -f elf32 -o " + sys.argv[1] + ".o " + sys.argv[1] + ".asm")
	
	os.system(t)
	

	print "[+]Linking..."
	
	s = ("ld -o " + sys.argv[1] + " " + sys.argv[1] + ".o")

	os.system(s)

	print """

		######################################################################
		#								     #
		#		object dump of the binary file			     #	
		#								     #		
		######################################################################
	"""

	obj = ("objdump -d " + sys.argv[1] + " -M intel")

	os.system(obj)
	
	print "==================>shellcode of the binary<=========================="
	
	w = (' |sed \'s/^/"/\'|sed \'s/$/"/g\'')
	
	s = ("objdump -d " + sys.argv[1] + " " + "|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\\x/g'|paste -d '' -s" + w)


	os.system(s)

	print "==================================================================="			

except Exception, e:

	print "[-]Error--->" + str(e)


