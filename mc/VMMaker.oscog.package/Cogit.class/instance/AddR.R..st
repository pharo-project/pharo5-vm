abstract instructions
AddR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddRR operand: reg1 operand: reg2