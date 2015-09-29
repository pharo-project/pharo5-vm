inline cacheing
implicitReceiveCacheAt: callSiteReturnAddress
	"Answer the implicit receiver cache for the return address
	 of a call to one of the ceImplicitReceiver... trampolines."
	self assert: (self instructionIsBL: (self instructionBeforeAddress: callSiteReturnAddress)).
	^self extract32BitOperandFrom4InstructionsPreceding: callSiteReturnAddress - 4