accessing
addDependent: anInstruction
	<var: #anInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	dependent notNil ifTrue:
		[anInstruction dependent: dependent].
	^dependent := anInstruction