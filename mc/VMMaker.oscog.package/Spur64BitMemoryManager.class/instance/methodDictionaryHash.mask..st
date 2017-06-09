interpreter access
methodDictionaryHash: oop mask: mask
	<inline: true>
	^mask bitAnd: ((self isImmediate: oop)
						ifTrue: [self integerValueOf: oop] "this will fail for SmallFloat64 but we don't care"
						ifFalse: [self rawHashBitsOf: oop]) "If no hash then it isn't in the dictionary..."