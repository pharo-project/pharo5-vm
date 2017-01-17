compile abstract instructions
checkLiteral: literal forInstruction: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	^anInstruction