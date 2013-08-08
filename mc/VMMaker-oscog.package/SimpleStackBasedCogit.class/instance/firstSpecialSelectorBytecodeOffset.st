bytecode generators
firstSpecialSelectorBytecodeOffset
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [bytecodeSetOffset = 256 ifTrue: [80 + 256] ifFalse: [176]]
		ifFalse: [176]