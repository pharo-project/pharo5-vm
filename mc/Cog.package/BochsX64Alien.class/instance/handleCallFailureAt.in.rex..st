error handling
handleCallFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a call into a ProcessorSimulationTrap signal."
	| relativeJump |
	self assert: rexByteOrNil isNil.
	relativeJump := memoryArray longAt: pc + 2 bigEndian: false.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 5
			address: (pc + 5 + relativeJump) signedIntToLong64
			type: #call)
		signal