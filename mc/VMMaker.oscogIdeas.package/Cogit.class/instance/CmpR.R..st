abstract instructions
CmpR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CmpRR operand: reg1 operand: reg2