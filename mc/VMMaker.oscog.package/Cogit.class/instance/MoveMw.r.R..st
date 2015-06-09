abstract instructions
MoveMw: offset r: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveMwrR quickConstant: offset operand: baseReg operand: destReg