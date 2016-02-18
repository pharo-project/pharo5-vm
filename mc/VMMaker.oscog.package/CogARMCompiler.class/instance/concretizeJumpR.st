generate machine code - concretize
concretizeJumpR
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating jumps.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| reg |
	reg := operands at: 0.
	"bx reg"
	self machineCodeAt: 0 put: (self bx: reg).
	^machineCodeSize := 4