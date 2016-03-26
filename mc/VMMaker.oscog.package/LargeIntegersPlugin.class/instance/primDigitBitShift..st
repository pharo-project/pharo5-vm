obsolete
primDigitBitShift: shiftCount 
	| rShift aLarge anInteger |
	self debugCode: [self msg: 'primDigitBitShift: shiftCount'].
	anInteger := self
				primitive: 'primDigitBitShift'
				parameters: #(SmallInteger )
				receiver: #Integer.
	(interpreterProxy isIntegerObject: anInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			aLarge := self createLargeFromSmallInteger: anInteger]
		ifFalse: [aLarge := anInteger].
	shiftCount >= 0
		ifTrue: [^ self digit: aLarge Lshift: shiftCount]
		ifFalse: 
			[rShift := 0 - shiftCount.
			^ self normalize: (self
					digit: aLarge
					Rshift: rShift
					lookfirst: (self digitSizeOfLargeInt: aLarge))]