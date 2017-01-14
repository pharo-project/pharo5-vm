abstract instructions
MoveM8: offset r: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveM8rR quickConstant: offset operand: baseReg operand: destReg