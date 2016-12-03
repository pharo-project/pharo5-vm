bytecode generator support
voidReceiverResultRegContainsSelf
	"Used when ReceiverResultReg is allocated for other than simSelf, and
	 there may be references to ReceiverResultReg which need to be spilled."
	| spillIndex |
	optStatus isReceiverResultRegLive: false.
	spillIndex := -1.
	(methodOrBlockNumTemps max: simSpillBase) to: simStackPtr do:
		[:i|
		(self simStackAt: i) registerOrNone = ReceiverResultReg ifTrue:
			[spillIndex := i]].
	spillIndex > 0 ifTrue:
		[self ssFlushTo: simStackPtr - spillIndex]