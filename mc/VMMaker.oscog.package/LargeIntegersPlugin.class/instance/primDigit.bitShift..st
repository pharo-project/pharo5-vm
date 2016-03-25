development primitives
primDigit: anInteger bitShift: shiftCount 
	| rShift aLarge |
	self debugCode: [self msg: 'primDigit: anInteger bitShift: shiftCount'].
	self
		primitive: '_primDigitBitShift'
		parameters: #(Integer SmallInteger )
		receiver: #Oop.
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
					Rshift: (rShift bitAnd: 7)
					bytes: (rShift bitShift: -3)
					lookfirst: (self digitSizeOfLargeInt: aLarge))]