primitive support
characterValueOf: oop
	<api>
	(self isCharacterObject: oop) ifFalse:
		[coInterpreter primitiveFailFor: PrimErrUnsupported.
		 ^-1].
	^self integerValueOf: (self fetchPointer: 0 ofObject: oop)