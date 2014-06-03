oop functions
digitMultiplyLarge: firstInteger with: secondInteger negative: neg 
	"Normalizes."
	| firstLen secondLen shortInt shortLen longInt longLen prod resultClass |
	firstLen := self byteSizeOfBytes: firstInteger.
	secondLen := self byteSizeOfBytes: secondInteger.
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
	neg
		ifTrue: [resultClass := interpreterProxy classLargeNegativeInteger]
		ifFalse: [resultClass := interpreterProxy classLargePositiveInteger].
	self remapOop: #(shortInt longInt ) in: [prod := interpreterProxy instantiateClass: resultClass indexableSize: longLen + shortLen].
	self
		cDigitMultiply: (interpreterProxy firstIndexableField: shortInt)
		len: shortLen
		with: (interpreterProxy firstIndexableField: longInt)
		len: longLen
		into: (interpreterProxy firstIndexableField: prod).
	^ self normalize: prod