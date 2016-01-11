error handling
handleMovOvAXFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a write of rax into a ProcessorSimulationTrap signal."
	self assert: rexByteOrNil = 16r48.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 10
			address: (memoryArray unsignedLong64At: pc + 3)
			type: #write
			accessor: #rax)
		signal