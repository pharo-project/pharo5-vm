simulation stack
ssAllocateRequiredReg: requiredReg1 and: requiredReg2
	self ssAllocateRequiredRegMask: ((self registerMaskFor: requiredReg1)
										bitOr: (self registerMaskFor: requiredReg2))
		upThrough: simStackPtr