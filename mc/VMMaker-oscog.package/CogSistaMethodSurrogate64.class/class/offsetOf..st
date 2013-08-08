accessing
offsetOf: aByteSymbol
	^aByteSymbol == #numCounters
		ifTrue: [40]
		ifFalse: [super offsetOf: aByteSymbol]