gmake commands
setAndroidVersion: version
	output 
		nextPutAll: ('APP_PLATFORM := ', version); 
		cr
