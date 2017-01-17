bytecode generator support
genStorePop: popBoolean TemporaryVariable: tempIndex
	<inline: false>
	popBoolean
		ifTrue: [self PopR: TempReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: TempReg].
	self MoveR: TempReg
		Mw: (self frameOffsetOfTemporary: tempIndex)
		r: FPReg.
	^0