abstract instructions
LogicalShiftLeftR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: LogicalShiftLeftRR operand: reg1 operand: reg2