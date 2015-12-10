accessing
addDependent: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	dependent ifNotNil:
		[anInstruction dependent: dependent].
	^dependent := anInstruction