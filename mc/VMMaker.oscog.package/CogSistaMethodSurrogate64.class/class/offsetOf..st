accessing
offsetOf: aByteSymbol
	"These should be generated!!"
	^aByteSymbol == #counters
		ifTrue: [32 + self objectMemoryClass baseHeaderSize]
		ifFalse: [super offsetOf: aByteSymbol]