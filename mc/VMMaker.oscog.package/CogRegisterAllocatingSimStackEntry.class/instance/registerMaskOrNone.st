accessing
registerMaskOrNone
	liveRegister ~= NoReg ifTrue:
		[^cogit registerMaskFor: register].
	^super registerMaskOrNone