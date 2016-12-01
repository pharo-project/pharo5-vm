accessing
registerMaskOrNone
	^type = SSRegister ifTrue: [cogit registerMaskFor: register] ifFalse: [0]