private - file handles
descriptorTableSize
	"dtl:
	 Answer the size of the file descriptor table for a process. I am not sure of the most portable
	 way to do this. If this implementation does not work on your Unix platform, try changing
	 it to answer the value of FOPEN:=MAX, which will hopefully be defined in stdio.h.

	eem:
		If we know that (e.g.) stdin is open we can use fd=dup(0);close(fd);fd instead."

	^self getdtablesize