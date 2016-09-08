abstract instructions
MoveA32: address R: reg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: (objectMemory wordSize = 8
					ifTrue: [MoveA32R]
					ifFalse: [MoveAwR])
		literal: address
		operand: reg