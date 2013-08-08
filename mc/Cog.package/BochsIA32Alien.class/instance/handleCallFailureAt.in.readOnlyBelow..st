error handling
handleCallFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Convert an execution primitive failure for a call into a ProcessorSimulationTrap signal."
	|  relativeJump |
	relativeJump := memoryArray longAt: pc + 2 bigEndian: false.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 5
			address: (pc + 5 + relativeJump) signedIntToLong
			type: #call)
		signal