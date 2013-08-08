private - file handles
descriptorTableSize
	"Answer the size of the file descriptor table for a process. I am not sure of the most portable
	way to do this. If this implementation does not work on your Unix platform, try changing
	it to answer the value of FOPEN:=MAX, which will hopefully be defined in stdio.h. If
	all else fails, just hard code it to answer 20, which would be safe for any Unix."

	^ self cCode: 'getdtablesize()' inSmalltalk: [20]
