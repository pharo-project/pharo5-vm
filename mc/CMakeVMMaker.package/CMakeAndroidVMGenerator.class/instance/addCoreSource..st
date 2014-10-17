gmake commands
addCoreSource: aFileName
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(LOCAL_PATH)/../srcVM/vm/', aFileName); 
		cr