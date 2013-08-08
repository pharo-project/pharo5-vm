development primitives
primDigitDiv: firstInteger with: secondInteger negative: neg 
	"Answer the result of dividing firstInteger by secondInteger.
	Fail if parameters are not integers or secondInteger is zero."
	| firstAsLargeInteger secondAsLargeInteger |
	self debugCode: [self msg: 'primDigitDiv: firstInteger with: secondInteger negative: neg'].
	self
		primitive: 'primDigitDivWithNegative'
		parameters: #(Integer Integer Boolean )
		receiver: #Oop.
	"Coerce SmallIntegers to corresponding (not normalized) large integers    
	 and check for zerodivide."
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: ["convert to LargeInteger"
			self remapOop: secondInteger in: [firstAsLargeInteger := self createLargeFromSmallInteger: firstInteger]]
		ifFalse: [firstAsLargeInteger := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue: 
			["check for zerodivide and convert to LargeInteger"
			(interpreterProxy integerValueOf: secondInteger)
				= 0 ifTrue: [^ interpreterProxy primitiveFail].
			self remapOop: firstAsLargeInteger in: [secondAsLargeInteger := self createLargeFromSmallInteger: secondInteger]]
		ifFalse: [secondAsLargeInteger := secondInteger].
	^ self
		digitDivLarge: firstAsLargeInteger
		with: secondAsLargeInteger
		negative: neg