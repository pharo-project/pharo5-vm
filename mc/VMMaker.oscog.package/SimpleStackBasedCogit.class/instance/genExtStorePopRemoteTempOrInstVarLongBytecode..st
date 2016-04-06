bytecode generators
genExtStorePopRemoteTempOrInstVarLongBytecode: boolean
	| index |
	extB := 0. "simple cogit don't use the extra flag"
	(byte2 noMask: 1 << 7)
		ifTrue: 
			[ self genStorePop: boolean RemoteTemp: byte1 At: byte2.
			self cppIf: IMMUTABILITY ifTrue: [ self annotateBytecode: self Label ] ]
		ifFalse: 
			[ index := byte1 + (extA << 8).
			extA := 0.
			(coInterpreter isWriteMediatedContextInstVarIndex: index)
				ifTrue: [ self 
						genStorePop: boolean 
						MaybeContextRemoteInstVar: index 
						ofObjectAt: byte2 - (1 << 7) ]
				ifFalse: [ self 
						genStorePop: boolean 
						RemoteInstVar: index 
						ofObjectAt: byte2 - (1 << 7)  ] ].
	^ 0