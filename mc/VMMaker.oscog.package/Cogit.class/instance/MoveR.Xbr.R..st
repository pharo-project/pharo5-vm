abstract instructions
MoveR: srcReg Xbr: indexReg R: baseReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRXbrR operand: srcReg operand: indexReg operand: baseReg