abstract instructions
MoveR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRR operand: reg1 operand: reg2