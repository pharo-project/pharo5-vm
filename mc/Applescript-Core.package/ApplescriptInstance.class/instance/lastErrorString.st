error handling
lastErrorString
	"Answer the error message for the last error"

	| aeDesc |
	aeDesc := AEDesc new.
	Applescript generic
		primOSAScriptError: (DescType of: 'errs')
		type: (DescType of: 'TEXT')
		to: aeDesc.
	^aeDesc asStringThenDispose