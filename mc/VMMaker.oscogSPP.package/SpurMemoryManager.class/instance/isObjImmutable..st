header access
isObjImmutable: anOop
	<inline: true>
	^self cppIf: IMMUTABILITY
		ifTrue: [self isImmutable: anOop]
		ifFalse: [false]