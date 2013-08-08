error handling
lastErrorNumber
	"Answer the error code number of the last error"

	| aeDesc |
	aeDesc := AEDesc new.
	Applescript generic 
		primOSAScriptError: (DescType of: 'errn')
		type: (DescType of: 'shor')
		to: aeDesc.
	^aeDesc asShortThenDispose
