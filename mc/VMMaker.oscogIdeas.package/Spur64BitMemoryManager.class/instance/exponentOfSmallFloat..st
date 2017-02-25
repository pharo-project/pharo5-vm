interpreter access
exponentOfSmallFloat: oop
	"Answer the exponent of the argument, a SmallFloat.
	 See section 61-bit Immediate Floats in the SpurMemoryManager class comment.
				msb                                              lsb 
				[8expsubset][52mantissa][1s][3tags]"
	| exp |
	self assert: (oop bitAnd: self tagMask) = self smallFloatTag.
	^oop asUnsignedInteger <= 15
		ifTrue: [0]
		ifFalse:
			[exp := oop asUnsignedInteger >> (self numTagBits + self smallFloatMantissaBits + 1).
			 exp + self smallFloatExponentOffset - 1022]