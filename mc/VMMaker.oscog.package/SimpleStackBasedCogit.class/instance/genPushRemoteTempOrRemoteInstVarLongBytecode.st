bytecode generators
genPushRemoteTempOrRemoteInstVarLongBytecode
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genPushRemoteTempLongBytecode ]
		ifFalse: [ self genPushRemoteInstVarLongBytecode ]