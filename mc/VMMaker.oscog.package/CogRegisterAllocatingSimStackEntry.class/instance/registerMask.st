accessing
registerMask
	"Answer a bit mask for the receiver's register, if any."
	liveRegister ~= NoReg ifTrue:
		[^cogit registerMaskFor: liveRegister].
	^super registerMask