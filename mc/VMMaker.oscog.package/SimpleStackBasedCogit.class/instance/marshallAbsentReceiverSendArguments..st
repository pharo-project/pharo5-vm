bytecode generators
marshallAbsentReceiverSendArguments: numArgs
	self assert: needsFrame.
	self putSelfInReceiverResultReg.

	"Shuffle arguments if necessary and push receiver."
	numArgs = 0
		ifTrue:
			[self PushR: ReceiverResultReg]
		ifFalse:
			[self MoveMw: 0 r: SPReg R: TempReg.
			self PushR: TempReg.
			2 to: numArgs do:
				[:index|
				self MoveMw: index * objectMemory wordSize r: SPReg R: TempReg.
				self MoveR: TempReg Mw: index - 1 * BytesPerWord r: SPReg].
			self MoveR: ReceiverResultReg Mw: numArgs * BytesPerWord r: SPReg].