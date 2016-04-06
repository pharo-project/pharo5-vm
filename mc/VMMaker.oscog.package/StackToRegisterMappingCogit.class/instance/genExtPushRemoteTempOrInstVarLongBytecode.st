bytecode generators
genExtPushRemoteTempOrInstVarLongBytecode
	| index maybeContext |
	^ (byte2 noMask: 1 << 7)
		ifTrue: [ self genPushRemoteTempLongBytecode ]
		ifFalse: 
			[ maybeContext := self extBSpecifiesMaybeContext.
			index := byte1 + (extA << 8).
			extA := 0.
			extB := 0.
			((coInterpreter isReadMediatedContextInstVarIndex: index) and: [ maybeContext ])
				ifTrue: [ self genPushMaybeContextRemoteInstVar: index inObjectAt: byte2 - (1 << 7) ]
				ifFalse: [ self genPushRemoteInstVar: index inObjectAt: byte2 - (1 << 7) ] ]