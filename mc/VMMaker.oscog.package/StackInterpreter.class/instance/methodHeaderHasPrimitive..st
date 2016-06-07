compiled methods
methodHeaderHasPrimitive: methodHeader
	"Note: We now have 10 bits of primitive index, but they are in two places
	 for temporary backward compatibility.  The time to unpack is negligible,
	 since the derived primitive function pointer is stored in the method cache."
	^objectMemory hasSpurMemoryManagerAPI
		ifTrue: [self alternateHeaderHasPrimitiveFlag: methodHeader]
		ifFalse:
			[MULTIPLEBYTECODESETS
				ifTrue:
					[(objectMemory headerIndicatesAlternateBytecodeSet: methodHeader)
						ifTrue: [self alternateHeaderHasPrimitiveFlag: methodHeader]
						ifFalse: [methodHeader anyMask: V3PrimitiveBitsMask]]
				ifFalse:
					[methodHeader anyMask: V3PrimitiveBitsMask]]