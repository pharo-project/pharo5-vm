error handling
lastBriefErrorString
	"Answer the brief error message for the last error"

	| aeDesc |
	aeDesc := AEDesc new.
	Applescript generic
		primOSAScriptError: (DescType of: 'errb')
		type: (DescType of: 'TEXT')
		to: aeDesc.
	^aeDesc asStringThenDispose