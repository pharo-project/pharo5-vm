Integer primitives
primDigitMultiply: secondInteger negative: neg 
	| firstLarge secondLarge firstInteger |
	self debugCode: [self msg: 'primDigitMultiply: secondInteger negative: neg'].
	firstInteger := self
				primitive: 'primDigitMultiplyNegative'
				parameters: #(#Oop #Boolean ).
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue:
			["convert it to a not normalized LargeInteger"
			self
				remapOop: secondInteger
				in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse:
			[(self isLargeIntegerOop: firstInteger) ifFalse: [^interpreterProxy primitiveFail].
			firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue:
			["convert it to a not normalized LargeInteger"
			self
				remapOop: firstLarge
				in: [secondLarge := self createLargeFromSmallInteger: secondInteger]]
		ifFalse:
			[(self isLargeIntegerOop: secondInteger) ifFalse: [^interpreterProxy primitiveFail].
			secondLarge := secondInteger].
	^ self
		digitMultiplyLarge: firstLarge
		with: secondLarge
		negative: neg