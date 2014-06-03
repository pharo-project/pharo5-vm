oop functions
digitSubLarge: firstInteger with: secondInteger 
	"Normalizes."
	| firstLen secondLen larger largerLen smaller smallerLen neg resLen res firstNeg |
	firstNeg := (interpreterProxy fetchClassOf: firstInteger)
				= interpreterProxy classLargeNegativeInteger.
	firstLen := self byteSizeOfBytes: firstInteger.
	secondLen := self byteSizeOfBytes: secondInteger.
	firstLen = secondLen ifTrue: 
		[[firstLen > 1
		  and: [(self digitOfBytes: firstInteger at: firstLen) = (self digitOfBytes: secondInteger at: firstLen)]]
			whileTrue: [firstLen := firstLen - 1].
		secondLen := firstLen].
	(firstLen < secondLen
	 or: [firstLen = secondLen
		 and: [(self digitOfBytes: firstInteger at: firstLen) < (self digitOfBytes: secondInteger at: firstLen)]])
		ifTrue: 
			[larger := secondInteger.
			largerLen := secondLen.
			smaller := firstInteger.
			smallerLen := firstLen.
			neg := firstNeg == false]
		ifFalse: 
			[larger := firstInteger.
			largerLen := firstLen.
			smaller := secondInteger.
			smallerLen := secondLen.
			neg := firstNeg].
	resLen := largerLen.
	self remapOop: #(smaller larger)
		in: [res := interpreterProxy
					instantiateClass: (neg
										ifTrue: [interpreterProxy classLargeNegativeInteger]
										ifFalse: [interpreterProxy classLargePositiveInteger])
					indexableSize: resLen].
	self
		cDigitSub: (interpreterProxy firstIndexableField: smaller)
		len: smallerLen
		with: (interpreterProxy firstIndexableField: larger)
		len: largerLen
		into: (interpreterProxy firstIndexableField: res).
	^neg 
		ifTrue: [self normalizeNegative: res]
		ifFalse: [self normalizePositive: res]