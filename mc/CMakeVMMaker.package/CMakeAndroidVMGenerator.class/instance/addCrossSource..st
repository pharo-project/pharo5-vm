gmake commands
addCrossSource: aFileName
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(TOP_PATH)/platforms/Cross/vm/', aFileName); 
		cr