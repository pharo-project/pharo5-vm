abstract instructions
XorR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: XorRR operand: reg1 operand: reg2