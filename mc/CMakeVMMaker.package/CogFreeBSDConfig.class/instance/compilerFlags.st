as yet unclassified
compilerFlags

	"Common compiler flags
	
	
	LSB_FIRST=1 means that target platform is little endian. 
	set it to 0 for big-endian platforms
	
	"
	
	^ super compilerFlags, ' -I/usr/local/include'