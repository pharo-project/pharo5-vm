abstract instructions
MoveRd: sourceDPReg M64: offset r: baseReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRdM64r operand: sourceDPReg quickConstant: offset operand: baseReg