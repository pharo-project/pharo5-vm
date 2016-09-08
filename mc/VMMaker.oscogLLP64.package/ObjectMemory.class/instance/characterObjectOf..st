object access
characterObjectOf: characterCode
	<api>
	^(characterCode between: 0 and: 255)
		ifTrue: [self fetchPointer: characterCode ofObject: self characterTable]
		ifFalse: [nilObj]