abstract instructions
SignExtend32R: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SignExtend32RR operand: reg1 operand: reg2