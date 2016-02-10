gmake commands
addPlatformSource: aFileName  platform: name
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(TOP_PATH)/platforms/',name,'/vm/', aFileName); 
		cr