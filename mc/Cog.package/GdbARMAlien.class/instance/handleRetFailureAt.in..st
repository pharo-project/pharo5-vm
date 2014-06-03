error handling
handleRetFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a ret into a ProcessorSimulationTrap signal."
	self halt.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: (memoryArray unsignedLongAt: self sp -3) 
			type: #return
			accessor: #pc:)
		signal