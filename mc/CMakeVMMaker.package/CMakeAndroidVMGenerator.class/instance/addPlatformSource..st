gmake commands
addPlatformSource: aFileName
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(TOP_PATH)/platforms/unix/vm/', aFileName); 
		cr