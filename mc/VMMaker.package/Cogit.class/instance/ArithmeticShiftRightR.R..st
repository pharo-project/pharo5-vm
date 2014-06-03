abstract instructions
ArithmeticShiftRightR: reg1 R: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ArithmeticShiftRightRR operand: reg1 operand: reg2