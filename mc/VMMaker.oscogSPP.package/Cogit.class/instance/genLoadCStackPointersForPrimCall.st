trampoline support
genLoadCStackPointersForPrimCall
	debugPrimCallStackOffset = 0
		ifTrue:
			[self MoveAw: self cStackPointerAddress R: SPReg]
		ifFalse:
			[self MoveAw: self cStackPointerAddress R: TempReg.
			 self SubCq: debugPrimCallStackOffset R: TempReg.
			 self MoveR: TempReg R: SPReg].
	cFramePointerInUse ifTrue:
		[self MoveAw: self cFramePointerAddress R: FPReg].
	^0