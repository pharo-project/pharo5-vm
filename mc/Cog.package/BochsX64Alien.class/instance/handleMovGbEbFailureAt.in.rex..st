error handling
handleMovGbEbFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a byte register load into a ProcessorSimulationTrap signal."
	| modrmByte offset size |
	modrmByte := memoryArray byteAt: pc + 3.
	(modrmByte bitAnd: 16rC0) caseOf: {
		[16r80 "ModRegRegDisp32"] -> [offset := memoryArray unsignedLongAt: pc + 4 bigEndian: false.
										 size := 7].
		[16r40 "ModRegRegDisp8"] -> [offset := memoryArray byteAt: pc + 4.
										offset > 127 ifTrue: [offset := offset - 256].
										 size := 4] }
		otherwise: [self reportPrimitiveFailure].
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + size
			address: (((self perform: (self registerStateGetters at: (modrmByte bitAnd: 7) + ((rexByteOrNil bitAnd: 1) bitShift: 3) + 1))
					+ offset)
						bitAnd: 16rFFFFFFFFFFFFFFFF)
			type: #read
			accessor: (#(al: cl: dl: bl: spl: bpl: sil: dil: r8l: r9l: r10l: r11l: r12l: r13l: r14l: r15l:) at: ((modrmByte >> 3 bitAnd: 7) + ((rexByteOrNil bitAnd: 4) bitShift: 1) + 1)))
		signal