bytecode generators
genExtStoreAndPopRemoteTempOrRemoteInstVarLongBytecode
	| index |
	index := byte1 + (extA << 8).
	extA := 0.
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genStorePop: true RemoteTemp: byte1 At: byte2 ]
		ifFalse: [ self genStorePop: true RemoteInstVar: index At: byte2 - (1 << 7) ]