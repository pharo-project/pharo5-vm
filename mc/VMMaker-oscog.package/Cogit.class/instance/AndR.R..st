abstract instructions
AndR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AndRR operand: reg1 operand: reg2