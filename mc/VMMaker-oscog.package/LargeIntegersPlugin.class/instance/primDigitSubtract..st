Integer primitives
primDigitSubtract: secondInteger 
	| firstLarge secondLarge firstInteger |
	self debugCode: [self msg: 'primDigitSubtract: secondInteger'].
	firstInteger := self
				primitive: 'primDigitSubtract'
				parameters: #(#Integer )
				receiver: #Integer.
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self
				remapOop: secondInteger
				in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse: [firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self
				remapOop: firstLarge
				in: [secondLarge := self createLargeFromSmallInteger: secondInteger]]
		ifFalse: [secondLarge := secondInteger].
	^ self digitSubLarge: firstLarge with: secondLarge