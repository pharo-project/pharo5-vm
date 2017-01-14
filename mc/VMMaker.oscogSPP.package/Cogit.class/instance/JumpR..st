abstract instructions
JumpR: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: JumpR operand: reg