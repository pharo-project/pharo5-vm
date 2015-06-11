generate machine code - support
inverseOpcodeFor: opcode
	"Several of the opcodes are inverses.  Answer the inverse for an opcode if it has one.
	 See Table A3-2 in sec A3.4 Data-processing instructions of the AARM."
	^opcode caseOf: {
			[AddOpcode]		->	[SubOpcode].
			[AndOpcode]		->	[BicOpcode].
			[BicOpcode]		->	[AndOpcode].
			[CmpOpcode]		->	[CmpNotOpcode].
			[MoveOpcode]		->	[MoveNotOpcode].
			[MoveNotOpcode]	->	[MoveOpcode].
			[SubOpcode]		->	[AddOpcode] }
		otherwise: [self error: 'opcode has no inverse']