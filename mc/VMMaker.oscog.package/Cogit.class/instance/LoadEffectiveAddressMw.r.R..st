abstract instructions
LoadEffectiveAddressMw: offset r: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: LoadEffectiveAddressMwrR quickConstant: offset operand: baseReg operand: destReg