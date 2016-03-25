oop functions
digitSubLarge: firstInteger with: secondInteger 
	"Normalizes."
	| firstLen secondLen larger largerLen smaller smallerLen neg resLen res firstNeg |
	firstNeg := (interpreterProxy fetchClassOf: firstInteger)
				= interpreterProxy classLargeNegativeInteger.
	firstLen := self digitSizeOfLargeInt: firstInteger.
	secondLen := self digitSizeOfLargeInt: secondInteger.
	firstLen = secondLen ifTrue: 
		[[firstLen > 1
		  and: [(self digitOfLargeInt: firstInteger at: firstLen) = (self digitOfLargeInt: secondInteger at: firstLen)]]
			whileTrue: [firstLen := firstLen - 1].
		secondLen := firstLen].
	(firstLen < secondLen
	 or: [firstLen = secondLen
		 and: [(self digitOfLargeInt: firstInteger at: firstLen) < (self digitOfLargeInt: secondInteger at: firstLen)]])
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