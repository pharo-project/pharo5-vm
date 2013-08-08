gmake commands
includeDirectories: aString
	output 
		nextPutAll: ('COG_INCLUDE_DIRS += ', aString); 
		cr
