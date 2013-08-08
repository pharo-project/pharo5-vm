abstract instructions
PushR: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: PushR operand: reg