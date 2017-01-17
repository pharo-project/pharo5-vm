abstract instructions
ZeroExtend32R: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ZeroExtend32RR operand: reg1 operand: reg2