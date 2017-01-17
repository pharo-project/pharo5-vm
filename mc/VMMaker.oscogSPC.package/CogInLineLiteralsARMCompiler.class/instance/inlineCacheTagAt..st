inline cacheing
inlineCacheTagAt: callSiteReturnAddress
	"Answer the inline cache tag for the return address of a send."
	self assert: (self instructionIsBL: (self instructionBeforeAddress: callSiteReturnAddress)).
	^self extract32BitOperandFrom4InstructionsPreceding: callSiteReturnAddress - 4