abstract instructions
SubR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SubRR operand: reg1 operand: reg2