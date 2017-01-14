inline cacheing
rewriteInlineCacheTag: cacheTag at: callSiteReturnAddress
	"Rewrite an inline cache with a new tag.  This variant is used
	 by the garbage collector."
	
	"MoveCwR ClassReg selectorIndex/expectedClass
	 Call: unlinked send stub/expectedTarget
	 Push ReceiverResult <-- callSiteReturnAddress"
	
	"lui s3, selector/tagHigh
	 ori s3, s3, selector/tagLow
	 lui t9, stub/targetHigh
	 ori t9, t9, stub/targetLow
	 jalr t9
	 nop (delay slot)
	 ...  <-- callSiteReturnAddress"
	
	<var: #callSiteReturnAddress type: #usqInt>
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 24 to: callSiteReturnAddress."

	self literalAtAddress: callSiteReturnAddress - 20 put: cacheTag.

	self assert: (self opcodeAtAddress: callSiteReturnAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 24 to: callSiteReturnAddress."