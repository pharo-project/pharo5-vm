inline cacheing
rewriteInlineCacheAt: callSiteReturnAddress tag: cacheTag target: callTargetAddress
	"Rewrite an inline cache to call a different target for a new tag.  This variant is used
	 to link unlinked sends in ceSend:to:numArgs: et al.  Answer the extent of the code
	 change which is used to compute the range of the icache to flush."
	
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
	<var: #callTargetAddress type: #usqInt>
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 24 to: callSiteReturnAddress."

	self literalAtAddress: callSiteReturnAddress - 20 put: cacheTag.
	self literalAtAddress: callSiteReturnAddress - 12 put: callTargetAddress.

	self assert: (self opcodeAtAddress: callSiteReturnAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 24 to: callSiteReturnAddress."

	^24