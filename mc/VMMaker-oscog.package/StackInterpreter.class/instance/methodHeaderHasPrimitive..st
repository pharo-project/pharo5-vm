compiled methods
methodHeaderHasPrimitive: methodHeader
	"Note: We now have 10 bits of primitive index, but they are in two places
	 for temporary backward compatibility.  The time to unpack is negligible,
	 since the derived primitive function pointer is stored in the method cache."
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue: [(self headerIndicatesAlternateBytecodeSet: methodHeader)
				ifTrue: [self alternateHeaderHasPrimitiveFlag: methodHeader]
				ifFalse: [(methodHeader bitAnd: 16r200003FE) ~= 0]]
		ifFalse: [(methodHeader bitAnd: 16r200003FE) ~= 0]