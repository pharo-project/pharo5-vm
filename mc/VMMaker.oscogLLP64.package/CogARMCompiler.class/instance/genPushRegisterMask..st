generate machine code
genPushRegisterMask: registersToBeSavedMask
	<inline: true>
	^registersToBeSavedMask = 0
		ifTrue: [cogit Label]
		ifFalse: [cogit gen: PushSTM operand: registersToBeSavedMask]