accessing
receiverTagBitsForMethod: methodOop
	^(self objectForOop: methodOop) methodClass
		caseOf: {
			[SmallInteger]	-> [objectMemory smallIntegerTag].
			[Character]		-> [objectMemory characterTag].
			[SmallFloat64]	-> [objectMemory smallFloatTag] }
		otherwise: [0]