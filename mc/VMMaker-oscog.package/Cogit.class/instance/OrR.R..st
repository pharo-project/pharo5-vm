abstract instructions
OrR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: OrRR operand: reg1 operand: reg2