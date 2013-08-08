error handling
handleRetFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Convert an execution primitive failure for a ret into a ProcessorSimulationTrap signal."
	self halt.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: (memoryArray unsignedLongAt: self sp + 1)
			type: #return
			accessor: #pc:)
		signal