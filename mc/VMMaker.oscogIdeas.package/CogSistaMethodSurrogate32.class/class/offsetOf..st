accessing
offsetOf: aByteSymbol
	"These should be generated!!"
	^aByteSymbol == #counters
		ifTrue: [20 + self objectMemoryClass baseHeaderSize]
		ifFalse: [super offsetOf: aByteSymbol]