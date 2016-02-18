primitive support
positive32BitIntegerFor: integerValue
	"integerValue is interpreted as POSITIVE, e.g. as the result of Bitmap>at:.
	 N.B.  Returning in each arm separately enables Slang inlining.
	 /Don't/ return the ifTrue:ifFalse: unless Slang inlining of conditionals is fixed."
	<inline: true>
	objectMemory hasSixtyFourBitImmediates
		ifTrue:
			[^objectMemory integerObjectOf: (integerValue bitAnd: 16rFFFFFFFF)]
		ifFalse:
			[^self maybeInlinePositive32BitIntegerFor: integerValue]