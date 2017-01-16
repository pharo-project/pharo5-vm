abstract instructions
MoveR: sourceReg M64: offset r: baseReg 
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	self assert: BytesPerWord = 8.
	^self MoveR: sourceReg Mw: offset r: baseReg 