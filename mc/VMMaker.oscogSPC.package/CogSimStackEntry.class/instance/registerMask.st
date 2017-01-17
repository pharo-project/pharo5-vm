accessing
registerMask
	"Answer a bit mask for the receiver's register, if any."
	^(type = SSBaseOffset
		or: [type = SSRegister])
			ifTrue: [cogit registerMaskFor: register]
			ifFalse: [0]