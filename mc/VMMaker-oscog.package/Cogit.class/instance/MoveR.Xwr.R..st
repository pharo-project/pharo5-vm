abstract instructions
MoveR: sourceReg Xwr: indexReg R: baseReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRXwrR operand: sourceReg operand: indexReg operand: baseReg