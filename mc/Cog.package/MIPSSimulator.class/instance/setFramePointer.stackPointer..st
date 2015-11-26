processor api
setFramePointer: fp stackPointer: sp
	self signedRegister: SP put: sp.
	self signedRegister: FP put: fp.