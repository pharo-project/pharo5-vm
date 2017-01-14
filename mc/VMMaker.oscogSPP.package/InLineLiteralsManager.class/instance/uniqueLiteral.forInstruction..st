compile abstract instructions
uniqueLiteral: literal forInstruction: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	^anInstruction