bytecode generators
genExtStorePopRemoteTempOrInstVarLongBytecodePopBoolean: boolean
	| index maybeContext needsStoreCheck |
	needsStoreCheck := self sistaNeedsStoreCheck.
	maybeContext := self extBSpecifiesMaybeContext.
	extB := 0.
	(byte2 noMask: coInterpreter remoteIsInstVarAccess)
		ifTrue: 
			[ self genStorePop: boolean RemoteTemp: byte1 At: byte2 needsStoreCheck: needsStoreCheck.
			self cppIf: IMMUTABILITY ifTrue: [ self annotateBytecode: self Label ] ]
		ifFalse: 
			[ index := byte1 + (extA << 8).
			extA := 0.
			((coInterpreter isWriteMediatedContextInstVarIndex: index) and: [ maybeContext ])
				ifTrue: [ self 
						genStorePop: boolean 
						MaybeContextRemoteInstVar: index 
						ofObjectAt: byte2 - coInterpreter remoteIsInstVarAccess 
						needsStoreCheck: needsStoreCheck ]
				ifFalse: [ self 
						genStorePop: boolean 
						RemoteInstVar: index 
						ofObjectAt: byte2 - coInterpreter remoteIsInstVarAccess 
						needsStoreCheck: needsStoreCheck ] ].
	^ 0