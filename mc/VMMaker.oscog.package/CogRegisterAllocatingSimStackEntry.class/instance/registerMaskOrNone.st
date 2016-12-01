accessing
registerMaskOrNone
	liveRegister ~= NoReg ifTrue:
		[^cogit registerMaskFor: liveRegister].
	^super registerMaskOrNone