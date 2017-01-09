bytecode generators
genExtPushRemoteTempOrInstVarLongBytecode
	| index |
	^ (byte2 noMask: coInterpreter remoteIsInstVarAccess)
		ifTrue: [ self genPushRemoteTempLongBytecode ]
		ifFalse: 
			[ index := byte1 + (extA << 8).
			extA := 0.
			extB := 0. "don't use flags in the simple cogit"
			numExtB := 0.
			(coInterpreter isReadMediatedContextInstVarIndex: index)
				ifTrue: [self 
							genPushMaybeContextRemoteInstVar: index 
							inObjectAt: byte2 - coInterpreter remoteIsInstVarAccess]
				ifFalse: [self 
							genPushRemoteInstVar: index 
							inObjectAt: byte2 - coInterpreter remoteIsInstVarAccess]]