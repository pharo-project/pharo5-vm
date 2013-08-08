gmake commands
addDefinitions: aString
	output 
		nextPutAll: ('COG_CFLAGS += ', aString); 
		cr
