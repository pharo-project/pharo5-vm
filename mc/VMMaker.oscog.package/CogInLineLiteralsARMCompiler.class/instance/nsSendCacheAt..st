inline cacheing
nsSendCacheAt: callSiteReturnAddress
	"Answer the NSSendCache for the return address of a Newspeak
	 self, super, outer, or implicit receiver send."
	self assert: (self instructionIsBL: (self instructionBeforeAddress: callSiteReturnAddress)).
	^self extract32BitOperandFrom4InstructionsPreceding: callSiteReturnAddress - 4