bytecode generators
genExtPushRemoteTempOrInstVarLongBytecode
	| index |
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genPushRemoteTempLongBytecode ]
		ifFalse: 
			[ index := byte1 + (extA << 8).
			extA := 0.
			extB := 0. "don't use flags in the simple cogit"
			(coInterpreter isReadMediatedContextInstVarIndex: index)
				ifTrue: [ self genPushMaybeContextRemoteInstVar: index inObjectAt: byte2 - (1 << 7) ]
				ifFalse: [ self genPushRemoteInstVar: index inObjectAt: byte2 - (1 << 7) ] ]