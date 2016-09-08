abstract instructions
MoveM64: offset r: baseReg Rd: destDPReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveM64rRd quickConstant: offset operand: baseReg operand: destDPReg