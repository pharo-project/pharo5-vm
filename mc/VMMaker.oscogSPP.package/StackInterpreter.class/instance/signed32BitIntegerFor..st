primitive support
signed32BitIntegerFor: integerValue
	"Answer a full 32 bit integer object for the given integer value.
	 N.B.  Returning in each arm separately enables Slang inlining.
	 /Don't/ return the ifTrue:ifFalse: unless Slang inlining of conditionals is fixed."
	<inline: true>
	objectMemory hasSixtyFourBitImmediates
		ifTrue:
			[^objectMemory integerObjectOf: 
				(self cCode: [self cCoerceSimple: integerValue to: #int]
					inSmalltalk: [(integerValue bitAnd: 16r7FFFFFFF)
								- ((integerValue >> 31 anyMask: 1)
									ifTrue: [-16r100000000]
									ifFalse: [0])])]
		ifFalse:
			[(objectMemory isIntegerValue: integerValue) ifTrue:
				[^objectMemory integerObjectOf: integerValue].
			 ^self noInlineSigned32BitIntegerGutsFor: integerValue]