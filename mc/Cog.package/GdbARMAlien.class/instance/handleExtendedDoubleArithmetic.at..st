floating-point emulation
handleExtendedDoubleArithmetic: instr at: pc
	"Emulate an extended math - cmp/sqrt/sitod -  VFP instruction."
	| rn rd rm vn vm vd |
	rn := instr >> 16 bitAnd: 15.
	rd := instr >> 12 bitAnd: 15.
	rm := instr bitAnd: 15.
	vn := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rn + 18)). "Assume accesses fp regs"
	vm := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rm + 18)). "Assume accesses fp regs"

	"simplest to match the entire instruction pattern rather than mess around shifting and masking and merging"
	(instr  bitAnd: 16rFF00FF0)
		caseOf: {
		[16rEB80B80 "FCMPD"]	->
			["read rd, compare with rm (ignore rn) and set FPSCR NZCV flags. Sigh"
				vd := Float fromIEEE64BitWord: (self perform: (self registerStateGetters at: rd + 18)).
				self break].
		[16rEB80BC0 "FSITOD"]	->
			[| r |
			 r := vm asFloat.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].
		[16rEB10BC0 "FSQRTD"]	->
			[| r |
			 r := vm sqrt.
			 self perform: (self registerStateSetters at: rd + 18) with: r asIEEE64BitWord].
		}
		otherwise: [self reportPrimitiveFailure].
	self pc: pc + 4