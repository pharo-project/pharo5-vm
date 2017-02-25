bytecode generator support
numSpecialSelectors
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [bytecodeSetOffset = 256 ifTrue: [AltNumSpecialSelectors] ifFalse: [NumSpecialSelectors]]
		ifFalse: [NumSpecialSelectors]