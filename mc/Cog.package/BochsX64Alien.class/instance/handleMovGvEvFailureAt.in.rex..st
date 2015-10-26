error handling
handleMovGvEvFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a register load into a ProcessorSimulationTrap signal."
	| modrmByte getter setter offset |
	self assert: rexByteOrNil notNil.
	modrmByte := memoryArray byteAt: pc + 3.
	setter := self registerStateSetters at: ((modrmByte >> 3 bitAnd: 7) + ((rexByteOrNil bitAnd: 4) << 1) + 1).
	(modrmByte bitAnd: 16rC7) = 16r5 ifTrue: "ModRegInd & disp32"
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 7
				address: (memoryArray unsignedLongAt: pc + 4 bigEndian: false)
				type: #read
				accessor: setter)
			signal].
	getter := self registerStateGetters at: ((modrmByte bitAnd: 7) + ((rexByteOrNil bitAnd: 1) << 3) + 1).
	(modrmByte bitAnd: 16rC0) = 16r80 ifTrue: "ModRegRegDisp32"
		[offset := memoryArray longAt: pc + 4 bigEndian: false.
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 7
				address: (self perform: getter) + offset
				type: #read
				accessor: setter)
			signal].
	(modrmByte bitAnd: 16rC0) = 16r40 ifTrue: "ModRegRegDisp8"
		[offset := memoryArray byteAt: pc + 4.
		 offset > 16r7F ifTrue:
			[offset := offset - 16r100].
		 ^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 4
				address: (self perform: getter) + offset
				type: #read
				accessor: setter)
			signal].
	^self reportPrimitiveFailure