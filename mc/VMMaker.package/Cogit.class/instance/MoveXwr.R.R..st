abstract instructions
MoveXwr: indexReg R: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveXwrRR operand: indexReg operand: baseReg operand: destReg