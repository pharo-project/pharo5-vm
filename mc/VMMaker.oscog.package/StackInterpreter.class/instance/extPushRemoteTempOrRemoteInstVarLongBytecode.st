stack bytecodes
extPushRemoteTempOrRemoteInstVarLongBytecode
	| byte1 byte2 |
	byte1 := self fetchByte.
	byte2 := self fetchByte.
	self fetchNextBytecode.
	(byte2 noMask: 1 << 7)
		ifTrue: 
			[ self pushRemoteTemp: byte1 inVectorAt: byte2 ]
		ifFalse: 
			[ self extPushRemoteInstVar: byte1 inObjectAt: byte2 - (1 << 7) ]
	