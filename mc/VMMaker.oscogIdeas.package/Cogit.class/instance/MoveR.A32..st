abstract instructions
MoveR: reg A32: address
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: (objectMemory wordSize = 8
					ifTrue: [MoveRA32]
					ifFalse: [MoveRAw])
		operand: reg
		literal: address