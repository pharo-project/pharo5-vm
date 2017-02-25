abstract instructions
MoveM64: offset r: baseReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	self assert: BytesPerWord = 8.
	^self MoveMw: offset r: baseReg R: destReg
