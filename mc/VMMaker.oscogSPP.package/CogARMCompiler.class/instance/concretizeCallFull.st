generate machine code - concretize
concretizeCallFull
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating calls.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| jumpTarget instrOffset|
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self longJumpTargetAddress.
	instrOffset := self moveCw: jumpTarget intoR: ConcreteIPReg.
	"blx ConcreteIPReg"
	self machineCodeAt: instrOffset put: (self blx: ConcreteIPReg).
	self assert: instrOffset = self literalLoadInstructionBytes.
	^machineCodeSize := instrOffset + 4