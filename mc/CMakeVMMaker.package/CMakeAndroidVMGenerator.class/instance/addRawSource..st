gmake commands
addRawSource: aPathString
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += ', aPathString); 
		cr