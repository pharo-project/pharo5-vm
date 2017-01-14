bytecode generator support
firstSpecialSelectorBytecodeOffset
	<inline: true>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [bytecodeSetOffset = 256 ifTrue: [AltFirstSpecialSelector + 256] ifFalse: [FirstSpecialSelector]]
		ifFalse: [FirstSpecialSelector]