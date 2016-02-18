error handling
handleMovEvGvFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a register write into a ProcessorSimulationTrap signal."
	| modrmByte getter base offset |
	self assert: rexByteOrNil notNil.
	modrmByte := memoryArray byteAt: pc + 3.
	getter := self registerStateGetters at: ((modrmByte >> 3 bitAnd: 7) + ((rexByteOrNil bitAnd: 4) << 1) + 1).
	(modrmByte bitAnd: 16rC7) = 16r5 ifTrue: "ModRegInd & disp32"
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 7
				address: (memoryArray unsignedLongAt: pc + 4 bigEndian: false)
				type: #write
				accessor: getter)
			signal].
	(modrmByte bitAnd: 16rC0) = 16r80 ifTrue: "ModRegRegDisp32"
		[offset := memoryArray longAt: pc + 4 bigEndian: false.
		 base := self registerStateGetters at: ((modrmByte bitAnd: 7) + ((rexByteOrNil bitAnd: 1) << 3) + 1).
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 7
				address: (self perform: base) + offset
				type: #write
				accessor: getter)
			signal].
	(modrmByte bitAnd: 16rC0) = 16r40 ifTrue: "ModRegRegDisp8"
		[offset := memoryArray unsignedByteAt: pc + 4.
		 offset > 127 ifTrue: [offset := offset - 256].
		 base := self registerStateGetters at: ((modrmByte bitAnd: 7) + ((rexByteOrNil bitAnd: 1) << 3) + 1).
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: (self perform: base) + offset
				type: #write
				accessor: getter)
			signal].
	^self reportPrimitiveFailure