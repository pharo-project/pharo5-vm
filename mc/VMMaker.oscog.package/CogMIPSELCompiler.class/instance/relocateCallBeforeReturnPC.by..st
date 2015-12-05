inline cacheing
relocateCallBeforeReturnPC: retpc by: delta
	| target |
	self assert: delta \\ 4 = 0.
	delta = 0 ifTrue: [^self].
	
	self assert: (self opcodeAtAddress: retpc - 16) = LUI.
	self assert: (self opcodeAtAddress: retpc - 12) = ORI.
	self assert: (self opcodeAtAddress: retpc - 8) = SPECIAL.
	self assert: (self functionAtAddress: retpc - 8) = JALR.
	self assert: (objectMemory longAt: retpc - 4) = self nop.
	"cogit disassembleFrom: retpc - 16 to: retpc."

	target := self literalAtAddress: retpc - 12.
	target := target + delta.
	self literalAtAddress: retpc - 12 put: target.

	self assert: (self opcodeAtAddress: retpc - 16) = LUI.
	self assert: (self opcodeAtAddress: retpc - 12) = ORI.
	self assert: (self opcodeAtAddress: retpc - 8) = SPECIAL.
	self assert: (self functionAtAddress: retpc - 8) = JALR.
	self assert: (objectMemory longAt: retpc - 4) = self nop.
	"cogit disassembleFrom: retpc - 16 to: retpc."