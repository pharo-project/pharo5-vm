inline cacheing
rewriteCallAt: callSiteReturnAddress target: callTargetAddress
	"Rewrite a call instruction to call a different target.  This variant is used to link PICs
	 in ceSendMiss et al,.   
	Answer the extent of the code change which is used to compute the range of the icache to flush."
	<var: #callSiteReturnAddress type: #usqInt>
	<var: #callTargetAddress type: #usqInt>
	
	"lui t9, stub/targetHigh
	 ori t9, t9, stub/targetLow
	 jalr t9
	 nop (delay slot)
	 ...  <-- callSiteReturnAddress"
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 16 to: callSiteReturnAddress."

	self literalAtAddress: callSiteReturnAddress - 12 put: callTargetAddress.

	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 16 to: callSiteReturnAddress."

	^20