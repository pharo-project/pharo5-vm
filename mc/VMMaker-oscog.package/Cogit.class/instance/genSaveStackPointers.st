trampoline support
genSaveStackPointers
	self MoveR: FPReg Aw: coInterpreter framePointerAddress.
	self MoveR: SPReg Aw: coInterpreter stackPointerAddress.
	^0