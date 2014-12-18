interpreter access
smallFloatValueOf: oop
	"Answer the C double precision floating point value of the argument, a SmallFloat.
	 See section 61-bit Immediate Floats in the SpurMemoryManager class comment.
							msb                                              lsb 
	 Decode:				[8expsubset][52mantissa][1s][3tags] 
	 shift away tags:		[ 000 ][8expsubset][52mantissa][1s] 
	 add exponent offset:	[     11 exponent     ][52mantissa][1s] 
	 rot sign:				[1s][     11 exponent     ][52mantissa]"
	| rot |
	<returnTypeC: #double>
	self assert: (oop bitAnd: self tagMask) = self smallFloatTag.
	rot := oop >> self numTagBits.
	rot > 1 ifTrue:
		[rot := rot + (self smallFloatExponentOffset << (self smallFloatMantissaBits + 1))].
	rot := self rotateRight: rot.
	^self cCode: [(self cCoerce: (self addressOf: rot) to: #'double *') at: 0]
		inSmalltalk:
			[(Float new: 2)
				at: 1 put: rot >> 32;
				at: 2 put: (rot bitAnd: 16rFFFFFFFF);
				yourself]