gmake commands
addExternalLibrary: aString 
	output 
		nextPutAll: ('LOCAL_LDLIBS += ', aString); 
		cr