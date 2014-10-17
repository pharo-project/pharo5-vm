interpreter access
methodDictionaryHash: oop mask: mask
	<inline: true>
	^mask bitAnd: ((self isImmediate: oop)
						ifTrue: [self integerValueOf: oop]
						ifFalse: [self hashBitsOf: oop])