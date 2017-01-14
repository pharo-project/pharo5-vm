accessing
nativeRegisterMask
	"Answer a bit mask for the receiver's register, if any."
	^(((type = SSBaseOffset
		or: [type = SSNativeRegister])
		or: [type = SSRegisterSingleFloat])
		or: [type = SSRegisterDoubleFloat])
			ifTrue: [cogit registerMaskFor: register]
			ifFalse: [
				type = SSRegisterPair ifTrue: [(cogit registerMaskFor: register) bitOr: (cogit registerMaskFor: registerSecond)]
					ifFalse: [0]]