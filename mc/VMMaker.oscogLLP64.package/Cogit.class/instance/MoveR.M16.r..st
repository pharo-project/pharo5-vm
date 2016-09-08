abstract instructions
MoveR: srcReg M16: offset r: baseReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRM16r operand: srcReg quickConstant: offset operand: baseReg