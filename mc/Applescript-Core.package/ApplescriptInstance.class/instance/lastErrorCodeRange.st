error handling
lastErrorCodeRange
	"Answer the brief error message for the last error"

	| aeDesc recordDesc data from to |
	aeDesc := AEDesc new.
	recordDesc := AEDesc new.
	Applescript generic
		primOSAScriptError: (DescType of: 'erng')
		type: (DescType of: 'erng')
		to: aeDesc.
	aeDesc
		primAECoerceDesc: (DescType of: 'reco')
		to: recordDesc.
	aeDesc dispose.
	data := ByteArray new: 2.
	recordDesc
		primAEGetKeyPtr: (DescType of: 'srcs') 
		type: (DescType of: 'shor')
		actual: (DescType of: 'shor')
		to: data.
	from := data shortAt: 1 bigEndian: true.
	recordDesc
		primAEGetKeyPtr: (DescType of: 'srce') 
		type: (DescType of: 'shor')
		actual: (DescType of: 'shor')
		to: data.
	to := data shortAt: 1 bigEndian: true.
	recordDesc dispose.
	^ (from + 1) to: (to + 1)

