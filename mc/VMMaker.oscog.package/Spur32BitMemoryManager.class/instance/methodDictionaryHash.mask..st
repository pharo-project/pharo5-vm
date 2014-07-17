interpreter access
methodDictionaryHash: oop mask: mask
	<inline: true>
	^mask bitAnd: ((self isImmediate: oop)
						ifTrue: [(self isIntegerObject: oop)
									ifTrue: [self integerValueOf: oop]
									ifFalse: [self characterValueOf: oop]]
						ifFalse: [self hashBitsOf: oop])