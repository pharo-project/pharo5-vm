inline cacheing
nsSendCacheAt: callSiteReturnAddress
	"Answer the NSSendCache for the return address of a Newspeak
	 self, super, outer, or implicit receiver send."
	<option: #NewspeakVM>
	
	"ra - 24 lui s4, cacheHigh
	 ra - 20 ori s4, s4, cacheLow
	 ra - 16 lui t9, stubHigh
	 ra - 12 ori t9, t9, stubLow
	 ra - 8 jalr t9
	 ra - 4 nop (delay slot)"
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 24) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 20) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) = LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) = ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) = SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) = JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) = self nop.
	"cogit disassembleFrom: callSiteReturnAddress - 16 to: callSiteReturnAddress."
	^self literalAtAddress: callSiteReturnAddress - 20