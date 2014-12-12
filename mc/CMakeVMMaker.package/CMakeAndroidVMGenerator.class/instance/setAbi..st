gmake commands
setAbi: abi
	output 
		nextPutAll: ('APP_PLATFORM := ', abi); 
		cr
