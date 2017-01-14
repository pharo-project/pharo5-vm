bytecode generators
genPushReceiverBytecode
	needsFrame
		ifTrue:
			[self MoveMw: FoxMFReceiver r: FPReg R: TempReg.
			 self PushR: TempReg]
		ifFalse:
			[self PushR: ReceiverResultReg].
	^0