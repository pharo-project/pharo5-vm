gmake commands
addDriversSource: aFileName
	 output 
		nextPutAll: ('LOCAL_SRC_FILES += $(LOCAL_PATH)/', aFileName); 
		cr