floating-point emulation
handleFPLoadStore: instr at: pc
	"Emulate a VFP load/store instruction."
	| rn rd offset |
	rn := instr >> 16 bitAnd: 15.
	rd := instr >> 12 bitAnd: 15.
	offset := instr bitAnd: 16rFF.

	"examine the U and Lbits"
	(instr >>20  bitAnd: 16rF)
		caseOf: {
		[0"Store neg"]	->
			[| r addr|
			addr := (self register: rn) - (offset<<2).
			 r := self perform: (self registerStateGetters at: rd + 18).
			 self unsignedLongLongAt: addr put: r].
		[1"Load neg"]	->
			[| r addr|
			addr := (self register: rn) - (offset<<2).
			r := self unsignedLongLongAt: addr.
			 self perform: (self registerStateSetters at: rd + 18) with: r ].
		[8"Store pos"]	->
			[| r addr|
			addr := (self register: rn) + (offset<<2).
			 r := self perform: (self registerStateGetters at: rd + 18).
			 self unsignedLongLongAt: addr put: r].
		[9"Load pos"]	->
			[| r addr|
			addr := (self register: rn) + (offset<<2).
			r := self unsignedLongLongAt: addr.
			 self perform: (self registerStateSetters at: rd + 18) with: r ].}
		otherwise: [self reportPrimitiveFailure].
	self pc: pc + 4