gmake commands
addDefinitions: aString
	output 
		nextPutAll: ('LOCAL_CFLAGS += ', aString); 
		cr
