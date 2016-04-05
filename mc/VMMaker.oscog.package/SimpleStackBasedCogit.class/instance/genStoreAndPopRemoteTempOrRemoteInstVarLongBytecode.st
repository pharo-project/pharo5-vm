bytecode generators
genStoreAndPopRemoteTempOrRemoteInstVarLongBytecode
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genStorePop: true RemoteTemp: byte1 At: byte2 ]
		ifFalse: [ self genStorePop: true RemoteInstVar: byte1 At: byte2 - (1 << 7) ]