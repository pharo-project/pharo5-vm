bytecode generators
genPushReceiverVariable: index
	<inline: false>
	| maybeErr |
	needsFrame ifTrue:
		[self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg].
	maybeErr := objectRepresentation genLoadSlot: index sourceReg: ReceiverResultReg destReg: TempReg.
	maybeErr < 0 ifTrue:
		[^maybeErr].
	self PushR: TempReg.
	^0