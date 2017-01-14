instruction decoding
jump: delta
	"Unconditional Jump bytecode."
	self doJump: delta.
	self resetStackAfterBranchOrReturn