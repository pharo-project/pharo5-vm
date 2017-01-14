bytecode generators
genExtStorePopRemoteTempOrInstVarLongBytecodePopBoolean: popBoolean
	| index |
	extB := 0. "simple cogit don't use the extra flag"
	numExtB := 0.
	(byte2 noMask: coInterpreter remoteIsInstVarAccess)
		ifTrue: 
			[ self genStorePop: popBoolean RemoteTemp: byte1 At: byte2.
			self cppIf: IMMUTABILITY ifTrue: [ self annotateBytecode: self Label ] ]
		ifFalse: 
			[ index := byte1 + (extA << 8).
			extA := 0.
			(coInterpreter isWriteMediatedContextInstVarIndex: index)
				ifTrue: [ self 
						genStorePop: popBoolean 
						MaybeContextRemoteInstVar: index 
						ofObjectAt: byte2 - coInterpreter remoteIsInstVarAccess ]
				ifFalse: [ self 
						genStorePop: popBoolean 
						RemoteInstVar: index 
						ofObjectAt: byte2 - coInterpreter remoteIsInstVarAccess  ] ].
	^ 0