simulation stack
ssAllocateCallReg: requiredReg1 and: requiredReg2
	self ssAllocateRequiredRegMask: (callerSavedRegMask
										bitOr: ((self registerMaskFor: requiredReg1)
										bitOr: (self registerMaskFor: requiredReg2)))
		upThrough: simStackPtr