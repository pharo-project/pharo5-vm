accessing
registerOrNone
	liveRegister ~= NoReg ifTrue:
		[^liveRegister].
	^super registerOrNone