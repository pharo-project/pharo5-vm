Integer primitives
primDigitCompare: secondInteger 
	| firstVal secondVal firstInteger firstIsSmall secondIsSmall |
	self debugCode: [self msg: 'primDigitCompare: secondInteger'].
	firstInteger := self primitive: 'primDigitCompare'.
	"shortcut: aSmallInteger has to be smaller in Magnitude as aLargeInteger"
	firstIsSmall := interpreterProxy isIntegerObject: firstInteger.
	secondIsSmall := interpreterProxy isIntegerObject: secondInteger.
	firstIsSmall ifFalse: [(self isLargeIntegerOop: firstInteger) ifFalse: [^interpreterProxy primitiveFail]].
	secondIsSmall ifFalse: [(self isLargeIntegerOop: secondInteger) ifFalse: [^interpreterProxy primitiveFail]].
	firstIsSmall
		ifTrue: 
			[secondIsSmall
				ifTrue: 
					[(firstVal := interpreterProxy integerValueOf: firstInteger) > (secondVal := interpreterProxy integerValueOf: secondInteger)
						ifTrue: [^ 1 asOop: SmallInteger"first > second"]
						ifFalse: [firstVal < secondVal
								ifTrue: [^ -1 asOop: SmallInteger"first < second"]
								ifFalse: [^ 0 asOop: SmallInteger"first = second"]]]
				ifFalse: 
					[^ -1 asOop: SmallInteger"first < SECOND"]]
		ifFalse: 
			[secondIsSmall
				ifTrue: 
					[^ 1 asOop: SmallInteger"FIRST > second"]
				ifFalse: 
					[^ self digitCompareLarge: firstInteger with: secondInteger]]