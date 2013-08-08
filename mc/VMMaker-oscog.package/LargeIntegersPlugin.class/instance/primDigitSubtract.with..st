development primitives
primDigitSubtract: firstInteger with: secondInteger
	| firstLarge secondLarge |
	self debugCode: [self msg: 'primDigitSubtract: firstInteger with: secondInteger'].
	self
		primitive: 'primDigitSubtractWith'
		parameters: #(Integer Integer )
		receiver: #Oop.
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self remapOop: secondInteger in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse: [firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self remapOop: firstLarge in: [secondLarge := self createLargeFromSmallInteger: secondInteger]]
		ifFalse: [secondLarge := secondInteger].
	^ self digitSubLarge: firstLarge with: secondLarge