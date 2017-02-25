generate machine code
genPopRegisterMask: registersToBeSavedMask
	<inline: true>
	^registersToBeSavedMask = 0
		ifTrue: [cogit Label]
		ifFalse: [cogit gen: PopLDM operand: registersToBeSavedMask]