generate machine code - concretize
concretizeJumpR
	"Will get inlined into concretizeAt: switch."
	"Sizing/generating jumps.
		Jump targets can be to absolute addresses or other abstract instructions.
		Generating initial trampolines instructions may have no maxSize and be to absolute addresses.
		Otherwise instructions must have a machineCodeSize which must be kept to."
	<inline: true>
	| reg |
	reg := self concreteRegister: (operands at: 0).
	"mov pc, r?, #0"
	self machineCodeAt: 0 put: (self t: 0 o: 16rD s: 0 rn: 0 rd: PC shifterOperand: reg).
	^machineCodeSize := 4