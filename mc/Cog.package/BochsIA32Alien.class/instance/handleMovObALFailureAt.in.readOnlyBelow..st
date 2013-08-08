error handling
handleMovObALFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Convert an execution primitive failure for a write of eax into a ProcessorSimulationTrap signal."
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 5
			address: (memoryArray unsignedLongAt: pc + 2 bigEndian: false)
			type: #write
			accessor: #eax)
		signal