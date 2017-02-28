bytecode generator stores
genStorePop: popBoolean TemporaryVariable: tempIndex
	<inline: false>
	| reg |
	self ssFlushUpThroughTemporaryVariable: tempIndex.
	reg := self ssStorePop: popBoolean toPreferredReg: TempReg.
	self MoveR: reg
		Mw: (self frameOffsetOfTemporary: tempIndex)
		r: FPReg.
	(self simStackAt: tempIndex) bcptr: bytecodePC. "for debugging"
	^0