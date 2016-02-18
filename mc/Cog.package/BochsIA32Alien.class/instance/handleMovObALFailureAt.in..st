error handling
handleMovObALFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a byte write of al into a ProcessorSimulationTrap signal."
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 5
			address: (memoryArray unsignedLongAt: pc + 2 bigEndian: false)
			type: #write
			accessor: #al)
		signal