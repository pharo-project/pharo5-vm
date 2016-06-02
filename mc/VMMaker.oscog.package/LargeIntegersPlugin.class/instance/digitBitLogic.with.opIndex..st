oop functions
digitBitLogic: firstInteger with: secondInteger opIndex: opIx 
	"Bit logic here is only implemented for positive integers or Zero;
	if rec or arg is negative, it fails."
	| firstLarge secondLarge firstLen secondLen shortLen shortLarge longLen longLarge result |
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: 
			[(interpreterProxy integerValueOf: firstInteger) < 0 ifTrue:
				[^ interpreterProxy primitiveFail].
			"convert it to a not normalized LargeInteger"
			self remapOop: secondInteger in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse: 
			[(interpreterProxy isLargePositiveIntegerObject: firstInteger) ifFalse: [^ interpreterProxy primitiveFail].
			firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue: 
			[(interpreterProxy integerValueOf: secondInteger) < 0 ifTrue:
				[^ interpreterProxy primitiveFail].
			"convert it to a not normalized LargeInteger"
			self remapOop: firstLarge in: [secondLarge := self createLargeFromSmallInteger: secondInteger]]
		ifFalse: 
			[(interpreterProxy isLargePositiveIntegerObject: secondInteger) ifFalse: [^ interpreterProxy primitiveFail].
			secondLarge := secondInteger].
	firstLen := self byteSizeOfLargeInt: firstLarge.
	secondLen := self byteSizeOfLargeInt: secondLarge.
	firstLen < secondLen
		ifTrue: 
			[shortLen := firstLen.
			shortLarge := firstLarge.
			longLen := secondLen.
			longLarge := secondLarge]
		ifFalse: 
			[shortLen := secondLen.
			shortLarge := secondLarge.
			longLen := firstLen.
			longLarge := firstLarge].
	self remapOop: #(shortLarge longLarge) in:
		[result := interpreterProxy instantiateClass: interpreterProxy classLargePositiveInteger indexableSize: longLen].
	result ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	self
		cDigitOp: opIx
		short: (self pointerToFirstDigitOfLargeInt: shortLarge)
		len: shortLen + 3 // 4
		long: (self pointerToFirstDigitOfLargeInt: longLarge)
		len: longLen + 3 // 4
		into: (self pointerToFirstDigitOfLargeInt: result).
	interpreterProxy failed ifTrue: [^ 0].
	^self normalizePositive: result