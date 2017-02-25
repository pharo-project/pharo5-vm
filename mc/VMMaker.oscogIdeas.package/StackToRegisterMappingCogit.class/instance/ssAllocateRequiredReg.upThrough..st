simulation stack
ssAllocateRequiredReg: requiredReg upThrough: stackPtr
	self ssAllocateRequiredRegMask: (self registerMaskFor: requiredReg)
		upThrough: stackPtr