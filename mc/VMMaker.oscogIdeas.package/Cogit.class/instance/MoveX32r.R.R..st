abstract instructions
MoveX32r: indexReg R: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveX32rRR operand: indexReg operand: baseReg operand: destReg