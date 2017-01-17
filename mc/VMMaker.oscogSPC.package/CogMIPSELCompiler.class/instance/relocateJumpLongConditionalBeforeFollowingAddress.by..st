inline cacheing
relocateJumpLongConditionalBeforeFollowingAddress: pc by: delta	
	"lui t9, stub/targetHigh
	 ori t9, t9, stub/targetLow
	 jalr t9
	 nop (delay slot)
	 ...  <-- callSiteReturnAddress"

	self assert: (self opcodeAtAddress: pc - 16) = BNE.
	self assert: (objectMemory longAt: pc - 12) = self nop.
	self assert: (self opcodeAtAddress: pc - 8) = J.
	self assert: (objectMemory longAt: pc - 4) = self nop.
	"cogit disassembleFrom: pc - 16 to: pc."
	
	self rewriteJTypeAtAddress: pc - 8 delta: delta.

	self assert: (self opcodeAtAddress: pc - 16) = BNE.
	self assert: (objectMemory longAt: pc - 12) = self nop.
	self assert: (self opcodeAtAddress: pc - 8) = J.
	self assert: (objectMemory longAt: pc - 4) = self nop.
	"cogit disassembleFrom: pc - 16 to: pc."