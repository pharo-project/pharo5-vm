processor api
setFramePointer: fp stackPointer: sp
	self unsignedRegister: SP put: sp.
	self unsignedRegister: FP put: fp.