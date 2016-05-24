floating-point emulation
handleBasicDoubleArithmetic: instr at: pc
	"Emulate a basic math - add/sub/mul/div -  VFP instruction."
	| rn rd rm vn vm |
	rn := instr >> 16 bitAnd: 15.
	rd := instr >> 12 bitAnd: 15.
	rm := instr bitAnd: 15.
	vn := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rn + 18)). "Assume accesses fp regs"
	vm := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rm + 18)). "Assume accesses fp regs"

	"simplest to match the entire instruction pattern rather than mess around shifting and masking and merging"
	(instr  bitAnd: 16rFF00FF0)
		caseOf: {
		[16rE200B00 "FMULD"]	->
			[| r |
			 r := vn * vm.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].
		[16rE300B00 "FADDD"]	->
			[| r |
			 r := vn + vm.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].
		[16rE300B40 "FSUBD"]	->
			[| r |
			 r := vn - vm.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].
		[16rE800B00"FDIVD"]	->
			[| r |
			 r := vn / vm.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].}
		otherwise: [self reportPrimitiveFailure].
	self pc: pc + 4