abstract instructions
MoveMb: offset r: baseReg R: destReg
	"N.B.  This instruction is guaranteed to zero-extend the byte into destReg."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveMbrR quickConstant: offset operand: baseReg operand: destReg