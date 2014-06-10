abstract instructions
LogicalShiftRightR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: LogicalShiftRightRR operand: reg1 operand: reg2