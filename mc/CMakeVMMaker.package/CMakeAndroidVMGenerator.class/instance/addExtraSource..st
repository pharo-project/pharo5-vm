gmake commands
addExtraSource: aFileName
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(TOP_PATH)/build/', aFileName); 
		cr