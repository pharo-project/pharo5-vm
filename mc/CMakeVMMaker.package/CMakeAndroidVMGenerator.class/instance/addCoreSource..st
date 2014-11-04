gmake commands
addCoreSource: aFileName
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(TOP_PATH)/src/vm/', aFileName); 
		cr