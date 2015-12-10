inline cacheing
relocateJumpLongBeforeFollowingAddress: pc by: delta	
	"lui t9, stub/targetHigh
	 ori t9, t9, stub/targetLow
	 jr t9
	 nop (delay slot)
	 ...  <-- pc"

	| oldTarget newTarget |
	self assert: delta \\ 4 = 0.
	delta = 0 ifTrue: [^self].
	
	self assert: (self opcodeAtAddress: pc - 16) = LUI.
	self assert: (self opcodeAtAddress: pc - 12) = ORI.
	self assert: (self opcodeAtAddress: pc - 8) = SPECIAL.
	self assert: (self functionAtAddress: pc - 8) = JR.
	self assert: (objectMemory longAt: pc - 4) = self nop.
	"cogit disassembleFrom: pc - 16 to: pc."

	oldTarget := self literalAtAddress: pc - 12.
	newTarget := oldTarget + delta.
	self literalAtAddress: pc - 12 put: newTarget.

	self assert: (self opcodeAtAddress: pc - 16) = LUI.
	self assert: (self opcodeAtAddress: pc - 12) = ORI.
	self assert: (self opcodeAtAddress: pc - 8) = SPECIAL.
	self assert: (self functionAtAddress: pc - 8) = JR.
	self assert: (objectMemory longAt: pc - 4) = self nop.
	"cogit disassembleFrom: pc - 16 to: pc."