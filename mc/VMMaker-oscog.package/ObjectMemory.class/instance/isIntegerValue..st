interpreter access
isIntegerValue: intValue
	"Answer if the given value can be represented as a Smalltalk integer value.
	 In C, use a shift and XOR to set the sign bit if and only if the top two bits of the given
	 value are the same, then test the sign bit. Note that the top two bits are equal for
	 exactly those integers in the range that can be represented in 31-bits or 63-bits."
	<api>
	^self
		cCode: [(intValue bitXor: (intValue << 1)) >= 0]
		inSmalltalk: [intValue >= 16r-40000000 and: [intValue <= 16r3FFFFFFF]]