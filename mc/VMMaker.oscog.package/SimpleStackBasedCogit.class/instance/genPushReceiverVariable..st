bytecode generator support
genPushReceiverVariable: index
	<inline: false>
	| maybeErr |
	needsFrame ifTrue:
		[self putSelfInReceiverResultReg].
	maybeErr := objectRepresentation genLoadSlot: index sourceReg: ReceiverResultReg destReg: TempReg.
	maybeErr < 0 ifTrue:
		[^maybeErr].
	self PushR: TempReg.
	^0