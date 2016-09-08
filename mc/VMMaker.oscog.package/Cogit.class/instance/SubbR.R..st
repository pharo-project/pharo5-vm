abstract instructions
SubbR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SubbRR operand: reg1 operand: reg2