gmake commands
includeDirectories: aString
	output 
		nextPutAll: ('LOCAL_C_INCLUDES += ', aString); 
		cr
