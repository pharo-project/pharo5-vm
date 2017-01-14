simulation stack
ssAllocateRequiredReg: requiredReg
	self ssAllocateRequiredRegMask: (self registerMaskFor: requiredReg)
		upThrough: simStackPtr