Integer primitives
primDigitBitShiftMagnitude: shiftCount 
	| rShift aLarge anInteger |
	self debugCode: [self msg: 'primDigitBitShiftMagnitude: shiftCount'].
	anInteger := self
				primitive: 'primDigitBitShiftMagnitude'
				parameters: #(#SmallInteger )
				receiver: #Integer.
	(interpreterProxy isIntegerObject: anInteger)
		ifTrue: ["convert it to a not normalized LargeInteger"
			aLarge := self createLargeFromSmallInteger: anInteger]
		ifFalse: [aLarge := anInteger].
	shiftCount >= 0
		ifTrue: [^ self bytes: aLarge Lshift: shiftCount]
		ifFalse: 
			[rShift := 0 - shiftCount.
			^ self normalize: (self
					bytes: aLarge
					Rshift: (rShift bitAnd: 7)
					bytes: (rShift bitShift: -3)
					lookfirst: (self byteSizeOfBytes: aLarge))]