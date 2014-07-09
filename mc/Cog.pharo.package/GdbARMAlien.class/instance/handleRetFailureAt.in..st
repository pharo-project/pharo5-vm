error handling
handleRetFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a ret into a ProcessorSimulationTrap signal."
	self halt.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: self lr " for popping off stack version of retiurn -> (memoryArray unsignedLongAt: self sp -3) "
			type: #return
			"don't quite know what to do with this yet ->accessor: #pc:")
		signal