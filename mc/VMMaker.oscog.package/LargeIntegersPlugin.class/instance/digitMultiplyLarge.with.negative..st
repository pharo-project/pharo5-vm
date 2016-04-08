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
	self remapOop: #(shortInt longInt) in: [prod := self createLargeIntegerNeg: neg byteLength: longLen + shortLen].
	self
		cDigitMultiply: (self firstIndexableField: shortInt as: #'unsigned int *')
		len: shortLen + 3 // 4
		with: (self firstIndexableField: longInt as: #'unsigned int *')
		len: longLen + 3 // 4
		into: (self firstIndexableField: prod as: #'unsigned int *')
		len: longLen + shortLen + 3 // 4.
	^neg 
		ifTrue: [self normalizeNegative: prod]
		ifFalse: [self normalizePositive: prod]