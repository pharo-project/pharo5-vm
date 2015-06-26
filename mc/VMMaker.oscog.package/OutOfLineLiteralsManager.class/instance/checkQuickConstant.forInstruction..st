compile abstract instructions
checkQuickConstant: literal forInstruction: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	anInstruction usesOutOfLineLiteral ifTrue:
		[anInstruction dependent: (self locateLiteral: (self cCode: [literal] inSmalltalk: [literal bitAnd: 16rFFFFFFFF]))].
	^anInstruction