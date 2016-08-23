accessing
registerOrNone
	^type = SSRegister ifTrue: [register] ifFalse: [NoReg]