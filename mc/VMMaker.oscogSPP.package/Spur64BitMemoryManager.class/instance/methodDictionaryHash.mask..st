interpreter access
methodDictionaryHash: oop mask: mask
	<inline: true>
	^mask bitAnd: ((self isImmediate: oop)
						ifTrue: [self integerValueOf: oop] "this will fail for ShortFloat but we don't care"
						ifFalse: [self hashBitsOf: oop])