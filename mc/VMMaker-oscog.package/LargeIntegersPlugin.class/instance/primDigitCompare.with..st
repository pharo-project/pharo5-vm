development primitives
primDigitCompare: firstInteger with: secondInteger 
	| firstVal secondVal |
	self debugCode: [self msg: 'primDigitCompare: firstInteger with: secondInteger'].
	self
		primitive: 'primDigitCompareWith'
		parameters: #(Integer Integer )
		receiver: #Oop.
	"shortcut: aSmallInteger has to be smaller in Magnitude as aLargeInteger"
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: ["first"
			(interpreterProxy isIntegerObject: secondInteger)
				ifTrue: ["second"
					(firstVal := interpreterProxy integerValueOf: firstInteger) > (secondVal := interpreterProxy integerValueOf: secondInteger)
						ifTrue: [^ 1 asOop: SmallInteger"first > second"]
						ifFalse: [firstVal < secondVal
								ifTrue: [^ -1 asOop: SmallInteger"first < second"]
								ifFalse: [^ 0 asOop: SmallInteger"first = second"]]]
				ifFalse: ["SECOND" ^ -1 asOop: SmallInteger"first < SECOND"]]
		ifFalse: ["FIRST"
			(interpreterProxy isIntegerObject: secondInteger)
				ifTrue: ["second" ^ 1 asOop: SmallInteger"FIRST > second"]
				ifFalse: ["SECOND"
					^ self digitCompareLarge: firstInteger with: secondInteger]]