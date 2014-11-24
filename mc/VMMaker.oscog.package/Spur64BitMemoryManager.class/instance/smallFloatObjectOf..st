interpreter access
smallFloatObjectOf: aFloat
	"Encode the argument, aFloat in the SmallFloat range, as a tagged small float.
	 See section 61-bit Immediate Floats in the SpurMemoryManager class comment.

	 Encode:				[1s][     11 exponent     ][52mantissa] 
	 rot sign:				[     11 exponent     ][52mantissa][1s] 
	 sub exponent offset:	[ 000 ][8expsubset][52 mantissa][1s] 
	 shift:					[8expsubset][52 mantissa][1s][ 000 ] 
	 or/add tags:			[8expsubset][52mantissa][1s][3tags]"
	<inline: true>
	<var: #aFloat type: #double>
	| rawFloat rot |
	self assert: (self isSmallFloatValue: aFloat).
	rawFloat := self cCode: [(self cCoerce: (self addressOf: aFloat) to: 'sqLong *') at: 0]
					inSmalltalk: [(aFloat at: 1) << 32 + (aFloat at: 2)].
	rot := self rotateLeft: rawFloat.
	rot > 1 ifTrue:
		[rot := rot - (self smallFloatExponentOffset << (self smallFloatMantissaBits + 1)).
		 self assert: rot > 0].
	^self cCode: [rot << self numTagBits + self smallFloatTag]
		inSmalltalk: [((rot << self numTagBits) bitAnd: 16rFFFFFFFFFFFFFFFF) + self smallFloatTag]