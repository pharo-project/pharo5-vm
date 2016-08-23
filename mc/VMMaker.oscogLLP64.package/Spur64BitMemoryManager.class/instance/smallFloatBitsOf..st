interpreter access
smallFloatBitsOf: oop
	"Answer the ieee 754 double precision floating point bits of the argument, a SmallFloat.
	 See section 61-bit Immediate Floats in the SpurMemoryManager class comment.
							msb                                              lsb 
	 Decode:				[8expsubset][52mantissa][1s][3tags] 
	 shift away tags:		[ 000 ][8expsubset][52mantissa][1s] 
	 add exponent offset:	[     11 exponent     ][52mantissa][1s] 
	 rot sign:				[1s][     11 exponent     ][52mantissa]"
	| rot |
	<returnTypeC: #usqLong>
	<var: #rot type: #usqLong>
	self assert: (self isImmediateFloat: oop).
	rot := oop asUnsignedInteger >> self numTagBits.
	rot > 1 ifTrue: "a.k.a. ~= +/-0.0"
		[rot := rot + (self smallFloatExponentOffset << (self smallFloatMantissaBits + 1))].
	rot := self rotateRight: rot.
	^rot