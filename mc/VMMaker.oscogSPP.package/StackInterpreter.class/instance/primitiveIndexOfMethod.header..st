compiled methods
primitiveIndexOfMethod: theMethod header: methodHeader
	"Note: With the Squeak V3 format we now have 10 bits of primitive index, but they are
	 in two places for temporary backward compatibility.  The time to unpack is negligible,
	 since the derived primitive function pointer is stored in the method cache.  With the
	 Spur format we assume a 3-byte CallPrimitive with a little-endian 16-bit primitive index."
	<api>
	<inline: true>
	| firstBytecode |
	^objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[(self alternateHeaderHasPrimitiveFlag: methodHeader)
				ifTrue:
					[firstBytecode := self firstBytecodeOfAlternateHeader: methodHeader method: theMethod.
					 (objectMemory byteAt: firstBytecode + 1) + ((objectMemory byteAt: firstBytecode + 2) << 8)]
				ifFalse:
					[0]]
		ifFalse:
			[MULTIPLEBYTECODESETS
				ifTrue:
					[(objectMemory headerIndicatesAlternateBytecodeSet: methodHeader)
						ifTrue:
							[(self alternateHeaderHasPrimitiveFlag: methodHeader)
								ifTrue:
									[firstBytecode := self firstBytecodeOfAlternateHeader: methodHeader method: theMethod.
									 (objectMemory byteAt: firstBytecode + 1) + ((objectMemory byteAt: firstBytecode + 2) << 8)]
								ifFalse:
									[0]]
						ifFalse:
							[| primBits |
							 primBits := objectMemory integerValueOf: methodHeader.
							 (primBits bitAnd: 16r1FF) + (primBits >> 19 bitAnd: 16r200)]]
				ifFalse:
					[| primBits |
					 primBits := objectMemory integerValueOf: methodHeader.
					 (primBits bitAnd: 16r1FF) + (primBits >> 19 bitAnd: 16r200)]]