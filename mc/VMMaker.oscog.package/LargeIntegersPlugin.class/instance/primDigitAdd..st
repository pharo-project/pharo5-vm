Integer primitives
primDigitAdd: secondInteger
	| firstLarge secondLarge firstInteger |
	self debugCode: [self msg: 'primDigitAdd: secondInteger'].
	firstInteger := self primitive: 'primDigitAdd'.
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue:
			["convert it to a not normalized LargeInteger"
			self remapOop: secondInteger in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse:
			[(self isLargeIntegerOop: firstInteger) ifFalse: [^interpreterProxy primitiveFail].
			firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue:
			["convert it to a not normalized LargeInteger"
			self remapOop: firstLarge in: [secondLarge := self createLargeFromSmallInteger: secondInteger]]
		ifFalse:
			[(self isLargeIntegerOop: secondInteger) ifFalse: [^interpreterProxy primitiveFail].
			secondLarge := secondInteger].
	^ self digitAddLarge: firstLarge with: secondLarge