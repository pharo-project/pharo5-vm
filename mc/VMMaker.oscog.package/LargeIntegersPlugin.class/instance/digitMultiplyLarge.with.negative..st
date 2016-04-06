oop functions
digitMultiplyLarge: firstInteger with: secondInteger negative: neg 
	"Normalizes."
	| firstLen secondLen shortInt shortLen longInt longLen prod |
	firstLen := self byteSizeOfLargeInt: firstInteger.
	secondLen := self byteSizeOfLargeInt: secondInteger.
	firstLen <= secondLen
		ifTrue: 
			[shortInt := firstInteger.
			shortLen := firstLen.
			longInt := secondInteger.
			longLen := secondLen]
		ifFalse: 
			[shortInt := secondInteger.
			shortLen := secondLen.
			longInt := firstInteger.
			longLen := firstLen].
	self remapOop: #(shortInt longInt ) in: [prod := self createLargeIntegerNeg: neg byteLength: longLen + shortLen].
	self
		cDigitMultiply: (interpreterProxy firstIndexableField: shortInt)
		len: shortLen + 3 // 4
		with: (interpreterProxy firstIndexableField: longInt)
		len: longLen + 3 // 4
		into: (interpreterProxy firstIndexableField: prod)
		len: longLen + shortLen + 3 // 4.
	^neg 
		ifTrue: [self normalizeNegative: prod]
		ifFalse: [self normalizePositive: prod]