error handling
handleGroup5FailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a group 5 instruction into the relevant ProcessorSimulationTrap signal."
	| modrmByte getter |
	self assert: rexByteOrNil isNil.
	modrmByte := memoryArray byteAt: pc + 2.
	(modrmByte >> 3 bitAnd: 7)
		caseOf: {
			[2 "Call Ev"]	->	[getter := self registerStateGetters at: (modrmByte bitAnd: 7) + 1.
							^(ProcessorSimulationTrap
									pc: pc
									nextpc: pc + 2
									address: (self perform: getter)
									type: #call)
								signal].
			[4 "Jump Ev"]	->	[getter := self registerStateGetters at: (modrmByte bitAnd: 7) + 1.
							^(ProcessorSimulationTrap
									pc: pc
									nextpc: pc + 2
									address: (self perform: getter)
									type: #jump)
								signal] }