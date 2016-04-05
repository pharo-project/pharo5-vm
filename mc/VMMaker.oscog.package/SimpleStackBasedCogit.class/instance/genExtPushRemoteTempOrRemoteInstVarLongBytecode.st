bytecode generators
genExtPushRemoteTempOrRemoteInstVarLongBytecode
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genPushRemoteTempLongBytecode ]
		ifFalse: [ self genExtPushRemoteInstVarLongBytecode ]