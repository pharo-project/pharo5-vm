oop functions
digitAddLarge: firstInteger with: secondInteger 
	"Does not need to normalize!"
	| over firstDigitLen secondDigitLen shortInt shortDigitLen longInt longDigitLen sum newSum neg |
	<var: #over type: #'unsigned int'>
	firstDigitLen := self digitSizeOfLargeInt: firstInteger.
	secondDigitLen := self digitSizeOfLargeInt: secondInteger.
	neg := (interpreterProxy fetchClassOf: firstInteger)
		= interpreterProxy classLargeNegativeInteger.
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
	over := self
				cDigitAdd: (interpreterProxy firstIndexableField: shortInt)
				len: shortDigitLen
				with: (interpreterProxy firstIndexableField: longInt)
				len: longDigitLen
				into: (interpreterProxy firstIndexableField: sum).
	over > 0
		ifTrue: 
			["sum := sum growby: 1."
			self remapOop: sum in: [newSum := self createLargeIntegerNeg: neg byteLength: longDigitLen * 4 + 1].
			self
				cDigitCopyFrom: (interpreterProxy firstIndexableField: sum)
				to: (interpreterProxy firstIndexableField: newSum)
				len: longDigitLen.
			sum := newSum.
			"C index!"
			self cDigitOf: (interpreterProxy cCoerce: (interpreterProxy firstIndexableField: sum) to: 'unsigned int *')
				at: longDigitLen put: over]
		ifFalse:
			[sum := neg 
				ifTrue: [self normalizeNegative: sum]
				ifFalse: [self normalizePositive: sum]].
	^ sum