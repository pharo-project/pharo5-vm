abstract instructions
AddcR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddcRR operand: reg1 operand: reg2