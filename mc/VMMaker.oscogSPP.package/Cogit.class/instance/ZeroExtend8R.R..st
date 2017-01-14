abstract instructions
ZeroExtend8R: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ZeroExtend8RR operand: reg1 operand: reg2