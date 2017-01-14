simulation stack
ssAllocateRequiredFloatReg: requiredReg
	self ssAllocateRequiredFloatRegMask: (self registerMaskFor: requiredReg)
		upThrough: simStackPtr upThroughNative: simNativeStackPtr