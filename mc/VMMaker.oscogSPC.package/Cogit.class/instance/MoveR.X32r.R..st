abstract instructions
MoveR: sourceReg X32r: indexReg R: baseReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRX32rR operand: sourceReg operand: indexReg operand: baseReg