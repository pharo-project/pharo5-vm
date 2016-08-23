compile abstract instructions
uniqueLiteral: literal forInstruction: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	self assert: anInstruction usesOutOfLineLiteral.
	anInstruction dependent: (self allocateLiteral: literal).
	^anInstruction