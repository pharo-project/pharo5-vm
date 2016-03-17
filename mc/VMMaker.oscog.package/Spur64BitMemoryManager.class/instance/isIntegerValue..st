interpreter access
isIntegerValue: intValue
	"Answer if the given value can be represented as a Smalltalk integer value.
	 In 64-bits we use a 3 bit tag which leaves 61 bits for 2's complement signed
	 integers. In C, use a shift add and mask to test if the top 4 bits are all the same.
	 Since 16rFFFFFFFFFFFFFFFF >> 60 = 16rF the computation intValue >> 60 + 1 bitAnd: 16rF
	 maps in-range -ve values to 0 and in-range +ve values to 1."
	<api>
	^self
		cCode: [(intValue >> 60 + 1 bitAnd: 16rF) <= 1] "N.B. (16rFFFFFFFFFFFFFFFF >> 60) + 1 = 16"
		inSmalltalk: [intValue >= self minSmallInteger and: [intValue <= self maxSmallInteger]]