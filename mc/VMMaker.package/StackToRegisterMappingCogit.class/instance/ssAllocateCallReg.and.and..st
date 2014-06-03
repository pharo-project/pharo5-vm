simulation stack
ssAllocateCallReg: requiredReg1 and: requiredReg2 and: requiredReg3
	self ssAllocateRequiredRegMask: (callerSavedRegMask
										bitOr: ((self registerMaskFor: requiredReg1)
										bitOr: ((self registerMaskFor: requiredReg2)
										bitOr: (self registerMaskFor: requiredReg3))))
		upThrough: simStackPtr