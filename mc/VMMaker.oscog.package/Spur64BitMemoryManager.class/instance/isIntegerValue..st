interpreter access
isIntegerValue: intValue
	"Answer if the given value can be represented as a Smalltalk integer value.
	 In 64-bits we use a 3 bit tag which leaves 61 bits for 2's complement signed
	 integers. In C, use a shift add and mask to test if the top 4 bits are all the same."
	<api>
	^self
		cCode: [(intValue >> 60 + 1 bitAnd: 16rF) <= 1]
		inSmalltalk: [intValue >= -16r2000000000000000 and: [intValue <= 16r1FFFFFFFFFFFFFFF]]