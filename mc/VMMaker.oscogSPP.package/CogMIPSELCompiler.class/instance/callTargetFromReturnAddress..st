inline cacheing
callTargetFromReturnAddress: callSiteReturnAddress
	"csra - 16:	lui t9, high
	 csra - 12:	ori t9, low
	 csra - 8:	jalr t9
	 csra - 4:	nop (delay slot)"
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 16) == LUI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 12) == ORI.
	self assert: (self opcodeAtAddress: callSiteReturnAddress - 8) == SPECIAL.
	self assert: (self functionAtAddress: callSiteReturnAddress - 8) == JALR.
	self assert: (objectMemory longAt: callSiteReturnAddress - 4) == self nop. "Delay slot"
	^self literalAtAddress: callSiteReturnAddress - 12