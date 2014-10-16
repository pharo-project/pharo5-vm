gmake commands
addDependency: aName
	output 
		nextPutAll: ('LOCAL_SHARED_LIBRARIES := ', aName); 
		cr