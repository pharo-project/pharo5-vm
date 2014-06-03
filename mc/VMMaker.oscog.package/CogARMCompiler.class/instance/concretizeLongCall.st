generate machine code - concretize
concretizeLongCall
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating calls.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| jumpTarget instrOffset|
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self longJumpTargetAddress.
	instrOffset := self at: 0 moveCw: jumpTarget intoR: RISCTempReg.
	"blx RISCTempReg"
	self machineCodeAt: instrOffset put: (self blx: RISCTempReg).
	^machineCodeSize := instrOffset + 4