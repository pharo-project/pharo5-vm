accessing
offsetOf: aByteSymbol
	"These should be generated!!"
	self assert: self objectMemoryClass baseHeaderSize = BaseHeaderSize.
	^aByteSymbol == #counters
		ifTrue: [20 + BaseHeaderSize]
		ifFalse: [super offsetOf: aByteSymbol]