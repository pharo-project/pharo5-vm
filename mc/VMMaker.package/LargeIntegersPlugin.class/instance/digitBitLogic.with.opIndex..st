oop functions
digitBitLogic: firstInteger with: secondInteger opIndex: opIx 
	"Bit logic here is only implemented for positive integers or Zero;
	if rec or arg is negative, it fails."
	| firstLarge secondLarge firstLen secondLen shortLen shortLarge longLen longLarge result |
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: 
			[(interpreterProxy integerValueOf: firstInteger)
				< 0 ifTrue: [^ interpreterProxy primitiveFail].
			"convert it to a not normalized LargeInteger"
			self remapOop: secondInteger in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse: 
			[(interpreterProxy fetchClassOf: firstInteger)
				= interpreterProxy classLargeNegativeInteger ifTrue: [^ interpreterProxy primitiveFail].
			firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue: 
			[(interpreterProxy integerValueOf: secondInteger)
				< 0 ifTrue: [^ interpreterProxy primitiveFail].
			"convert it to a not normalized LargeInteger"
			self remapOop: firstLarge in: [secondLarge := self createLargeFromSmallInteger: secondInteger]]
		ifFalse: 
			[(interpreterProxy fetchClassOf: secondInteger)
				= interpreterProxy classLargeNegativeInteger ifTrue: [^ interpreterProxy primitiveFail].
			secondLarge := secondInteger].
	firstLen := self byteSizeOfBytes: firstLarge.
	secondLen := self byteSizeOfBytes: secondLarge.
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
	self remapOop: #(shortLarge longLarge ) in: [result := interpreterProxy instantiateClass: interpreterProxy classLargePositiveInteger indexableSize: longLen].
	self
		cByteOp: opIx
		short: (interpreterProxy firstIndexableField: shortLarge)
		len: shortLen
		long: (interpreterProxy firstIndexableField: longLarge)
		len: longLen
		into: (interpreterProxy firstIndexableField: result).
	interpreterProxy failed ifTrue: [^ 0].
	^ self normalizePositive: result