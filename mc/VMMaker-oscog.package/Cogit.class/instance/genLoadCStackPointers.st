trampoline support
genLoadCStackPointers
	self MoveAw: self cStackPointerAddress R: SPReg.
	cFramePointerInUse ifTrue:
		[self MoveAw: self cFramePointerAddress R: FPReg].
	^0