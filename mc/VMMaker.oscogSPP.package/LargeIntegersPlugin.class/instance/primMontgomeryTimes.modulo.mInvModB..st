Integer primitives
primMontgomeryTimes: secondOperandInteger modulo: thirdModuloInteger mInvModB: mInverseInteger
	| firstLarge secondLarge firstInteger thirdLarge mInv |
	<var: #mInv type: #'unsigned int'>
	self debugCode: [self msg: 'montgomeryTimes: secondOperandInteger modulo: thirdModuloInteger mInvModB: smallInverseInteger'].
	firstInteger := self
				primitive: 'primMontgomeryTimesModulo'
				parameters: #(Integer Integer Integer )
				receiver: #Integer.
	 mInv := interpreterProxy positive32BitValueOf: mInverseInteger.
	(interpreterProxy isIntegerObject: firstInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self remapOop: #(secondOperandInteger thirdModuloInteger) in: [firstLarge := self createLargeFromSmallInteger: firstInteger]]
		ifFalse: [firstLarge := firstInteger].
	(interpreterProxy isIntegerObject: secondOperandInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self remapOop: #(firstLarge thirdModuloInteger) in: [secondLarge := self createLargeFromSmallInteger: secondOperandInteger]]
		ifFalse: [secondLarge := secondOperandInteger].
	(interpreterProxy isIntegerObject: thirdModuloInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			self remapOop: #(firstLarge secondLarge) in: [thirdLarge := self createLargeFromSmallInteger: thirdModuloInteger]]
		ifFalse: [thirdLarge := thirdModuloInteger].
	^ self digitMontgomery: firstLarge times: secondLarge modulo: thirdLarge mInvModB: mInv