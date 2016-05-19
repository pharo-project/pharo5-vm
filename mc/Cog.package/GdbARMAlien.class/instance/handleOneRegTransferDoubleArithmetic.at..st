floating-point emulation
handleOneRegTransferDoubleArithmetic: instr at: pc
	"Emulate a one-register transfer VFP instruction."
	| rn rd rm vn vm |
	rn := instr >> 16 bitAnd: 15.
	rd := instr >> 12 bitAnd: 15.
	rm := instr bitAnd: 15.
	vn := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rn + 18)). "Assume accesses fp regs"
	vm := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rm + 18)). "Assume accesses fp regs"
	(instr >> 18 bitAnd: 31)
		caseOf: {
		[8 "FMULD"]	->
			[| r |
			 r := vn * vm.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].
		[12"FADDD/FSUBD"]	->
			[self shouldBeImplemented].
		[32"FDIVD"]	->
			[self shouldBeImplemented].
		[45"FCMPD"]	->
			[self shouldBeImplemented]. }
		otherwise: [self reportPrimitiveFailure].
	self pc: pc + 4