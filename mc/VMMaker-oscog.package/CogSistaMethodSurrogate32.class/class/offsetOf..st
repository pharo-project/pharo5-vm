accessing
offsetOf: aByteSymbol
	^aByteSymbol == #numCounters
		ifTrue: [24]
		ifFalse: [super offsetOf: aByteSymbol]