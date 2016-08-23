accessing
floatAt: index 
	^ (self at: index) isFloat
		ifTrue: [self at: index]
		ifFalse: [Float
				fromIEEE32Bit: (self at: index)]
