*MethodMassageCompatibility-bytecode generation
computeMethodHeaderForNumArgs: numArgs numTemps: numTemps numLits: numLits primitive: primitiveIndex
	| primBits |
	numTemps > 63 ifTrue:
		[^self error: 'Cannot compile -- too many temporary variables'].	
	numLits > 255 ifTrue:
		[^self error: 'Cannot compile -- too many literals'].
	primBits := primitiveIndex <= 16r1FF
					ifTrue: [primitiveIndex]
					ifFalse: "For now the high bit of primitive no. is in the 29th bit of header"
						[primitiveIndex > 16r3FF ifTrue: [self error: 'prim num too large'].
						 (primitiveIndex bitAnd: 16r1FF) + ((primitiveIndex bitAnd: 16r200) bitShift: 19)].
	^(numArgs bitShift: 24)
	+ (numTemps bitShift: 18)
	"+ (largeBit bitShift: 17)" "largeBit gets filled in later"
	+ (numLits bitShift: 9)
	+ primBits