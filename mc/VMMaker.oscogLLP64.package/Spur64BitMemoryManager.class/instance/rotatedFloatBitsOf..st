interpreter access
rotatedFloatBitsOf: oop
	"Answer the signed, but unadjusted value of a SmallFloat64, suitable for use as a hash.
	 Keeping the exponent unadjusted keeps the value in the SmallInteger range.
	 See section 61-bit Immediate Floats in the SpurMemoryManager class comment.
							msb                                             lsb 
	 Decode:				[8expsubset][52mantissa][1s][3tags] 
	 shift away tags & sign:	[   0000   ][8expsubset][52mantissa]
	 add sign:				[    ssss   ][8expsubset][52mantissa]"
	self assert: (self isImmediateFloat: oop).
	^oop asUnsignedInteger >> (self numTagBits + 1)
	 + ((oop anyMask: self smallFloatSignBit)
		ifTrue: [-1 asUnsignedInteger << (64 - self numTagBits - 1)]
		ifFalse: [0])