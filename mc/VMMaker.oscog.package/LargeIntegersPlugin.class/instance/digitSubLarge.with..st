oop functions
digitSubLarge: firstInteger with: secondInteger 
	"Normalizes."
	| firstDigitLen secondDigitLen larger largeDigitLen smaller smallerDigitLen neg resDigitLen res firstNeg |
	firstNeg := interpreterProxy isLargeNegativeIntegerObject: firstInteger.
	firstDigitLen := self digitSizeOfLargeInt: firstInteger.
	secondDigitLen := self digitSizeOfLargeInt: secondInteger.
	firstDigitLen = secondDigitLen ifTrue: 
		[[firstDigitLen > 1
		  and: [(self unsafeDigitOfLargeInt: firstInteger at: firstDigitLen) = (self unsafeDigitOfLargeInt: secondInteger at: firstDigitLen)]]
			whileTrue: [firstDigitLen := firstDigitLen - 1].
		secondDigitLen := firstDigitLen].
	(firstDigitLen < secondDigitLen
	 or: [firstDigitLen = secondDigitLen
		 and: [(self unsafeDigitOfLargeInt: firstInteger at: firstDigitLen) < (self unsafeDigitOfLargeInt: secondInteger at: firstDigitLen)]])
		ifTrue: 
			[larger := secondInteger.
			largeDigitLen := secondDigitLen.
			smaller := firstInteger.
			smallerDigitLen := firstDigitLen.
			neg := firstNeg == false]
		ifFalse: 
			[larger := firstInteger.
			largeDigitLen := firstDigitLen.
			smaller := secondInteger.
			smallerDigitLen := secondDigitLen.
			neg := firstNeg].
	resDigitLen := largeDigitLen.
	self remapOop: #(smaller larger)
		in: [res := self createLargeIntegerNeg: neg digitLength: resDigitLen].
	res ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	self
		cDigitSub: (self pointerToFirstDigitOfLargeInt: smaller)
		len: smallerDigitLen
		with: (self pointerToFirstDigitOfLargeInt: larger)
		len: largeDigitLen
		into: (self pointerToFirstDigitOfLargeInt: res).
	^neg 
		ifTrue: [self normalizeNegative: res]
		ifFalse: [self normalizePositive: res]