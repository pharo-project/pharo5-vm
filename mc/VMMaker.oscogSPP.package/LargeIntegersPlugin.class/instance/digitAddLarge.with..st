oop functions
digitAddLarge: firstInteger with: secondInteger 
	"Does not need to normalize!"
	| over firstDigitLen secondDigitLen shortInt shortDigitLen longInt longDigitLen sum newSum neg |
	<var: #over type: #'unsigned int'>
	firstDigitLen := self digitSizeOfLargeInt: firstInteger.
	secondDigitLen := self digitSizeOfLargeInt: secondInteger.
	neg := interpreterProxy isLargeNegativeIntegerObject: firstInteger.
	firstDigitLen <= secondDigitLen
		ifTrue: 
			[shortInt := firstInteger.
			shortDigitLen := firstDigitLen.
			longInt := secondInteger.
			longDigitLen := secondDigitLen]
		ifFalse: 
			[shortInt := secondInteger.
			shortDigitLen := secondDigitLen.
			longInt := firstInteger.
			longDigitLen := firstDigitLen].
	"	sum := Integer new: len neg: firstInteger negative."
	self remapOop: #(shortInt longInt ) in: [sum := self createLargeIntegerNeg: neg digitLength: longDigitLen].
	sum ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	over := self
				cDigitAdd: (self pointerToFirstDigitOfLargeInt: shortInt)
				len: shortDigitLen
				with: (self pointerToFirstDigitOfLargeInt: longInt)
				len: longDigitLen
				into: (self pointerToFirstDigitOfLargeInt: sum).
	over > 0
		ifTrue: 
			["sum := sum growby: 1."
			self remapOop: sum in: [newSum := self createLargeIntegerNeg: neg byteLength: longDigitLen * 4 + 1].
			newSum ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
			self
				cDigitCopyFrom: (self pointerToFirstDigitOfLargeInt: sum)
				to: (self pointerToFirstDigitOfLargeInt: newSum)
				len: longDigitLen.
			sum := newSum.
			"C index!"
			self cDigitOf: (self pointerToFirstDigitOfLargeInt: sum)
				at: longDigitLen put: over]
		ifFalse:
			[sum := neg 
				ifTrue: [self normalizeNegative: sum]
				ifFalse: [self normalizePositive: sum]].
	^ sum