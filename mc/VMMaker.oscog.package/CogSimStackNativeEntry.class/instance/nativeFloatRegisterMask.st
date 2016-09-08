accessing
nativeFloatRegisterMask
	"Answer a bit mask for the receiver's register, if any."
	^ (type = SSRegisterSingleFloat or: [type = SSRegisterDoubleFloat])
			ifTrue: [cogit registerMaskFor: register]
			ifFalse: [0]