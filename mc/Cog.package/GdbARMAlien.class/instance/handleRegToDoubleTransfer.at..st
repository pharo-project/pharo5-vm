floating-point emulation
handleRegToDoubleTransfer: instr at: pc
	"Emulate an ARM to VFP instruction."
	| rn rd vn |
	rn := (instr >> 16 bitAnd: 15) << 1 bitOr: (instr >>6 bitAnd: 1).
	rd := instr >> 12 bitAnd: 15.
	vn := self register: rn.

	self perform: (self registerStateSetters at: rd + 18) with: vn.
	self pc: pc + 4