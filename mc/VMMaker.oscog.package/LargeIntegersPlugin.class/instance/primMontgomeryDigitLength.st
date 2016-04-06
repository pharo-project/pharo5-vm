Integer primitives
primMontgomeryDigitLength
	self debugCode: [self msg: 'primMontgomeryDigitLength'].
	self
				primitive: 'primMontgomeryDigitLength'
				parameters: #()
				receiver: #Integer.
	^interpreterProxy integerObjectOf: 32