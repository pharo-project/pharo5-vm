abstract instructions
SignExtend8R: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SignExtend8RR operand: reg1 operand: reg2