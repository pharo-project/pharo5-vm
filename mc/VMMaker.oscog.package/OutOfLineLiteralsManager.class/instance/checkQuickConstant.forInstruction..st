compile abstract instructions
checkQuickConstant: literal forInstruction: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	anInstruction usesOutOfLineLiteral ifTrue:
		[anInstruction dependent: (self locateLiteral: (self cCode: [literal] inSmalltalk: [literal bitAnd: 1 << (objectMemory wordSize * 8) - 1]))].
	^anInstruction