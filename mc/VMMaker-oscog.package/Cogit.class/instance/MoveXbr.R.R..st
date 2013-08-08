abstract instructions
MoveXbr: indexReg R: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveXbrRR operand: indexReg operand: baseReg operand: destReg