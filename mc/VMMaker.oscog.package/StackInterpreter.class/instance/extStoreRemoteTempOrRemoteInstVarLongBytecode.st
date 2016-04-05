stack bytecodes
extStoreRemoteTempOrRemoteInstVarLongBytecode
	| byte1 byte2 |
	byte1 := self fetchByte.
	byte2 := self fetchByte.
	self fetchNextBytecode.
	(byte2 noMask: 1 << 7)
		ifTrue: 
			[ self storeRemoteTemp: byte1 inVectorAt: byte2 ]
		ifFalse: 
			[ self extStoreRemoteInstVar: byte1 inObjectAt: byte2 - (1 << 7) ]
	