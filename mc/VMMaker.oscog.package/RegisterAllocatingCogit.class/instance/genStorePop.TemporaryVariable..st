bytecode generator support
genStorePop: popBoolean TemporaryVariable: tempIndex
	"Override so that if a register other than TempReg is allocated, the temp is marked as being live in that register."
	| reg |
	self ssFlushUpThroughTemporaryVariable: tempIndex.
	reg := self ssStorePop: popBoolean toPreferredReg: TempReg.
	self MoveR: reg
		Mw: (self frameOffsetOfTemporary: tempIndex)
		r: FPReg.
	reg ~= TempReg ifTrue:
		[(self simStackAt: tempIndex) liveRegister: reg].
	^0