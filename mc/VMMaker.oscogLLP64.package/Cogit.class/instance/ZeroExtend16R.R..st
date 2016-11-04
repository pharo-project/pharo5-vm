abstract instructions
ZeroExtend16R: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ZeroExtend16RR operand: reg1 operand: reg2