bytecode generators
genStoreRemoteTempOrRemoteInstVarLongBytecode
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genStorePop: false RemoteTemp: byte1 At: byte2 ]
		ifFalse: [ self genStorePop: false RemoteInstVar: byte1 At: byte2 - (1 << 7) ]