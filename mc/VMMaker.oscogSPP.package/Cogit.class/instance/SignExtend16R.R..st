abstract instructions
SignExtend16R: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SignExtend16RR operand: reg1 operand: reg2