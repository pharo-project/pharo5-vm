error handling
handleMovALObFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a read into rax/eax into a ProcessorSimulationTrap signal."
	rexByteOrNil ifNotNil:
		[^(ProcessorSimulationTrap
				pc: pc
				nextpc: pc + 10
				address: (memoryArray unsignedLong64At: pc + 3)
				type: #read
				accessor: #rax:)
			signal].
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 5
			address: (memoryArray unsignedLongAt: pc + 2)
			type: #read
			accessor: #eax:)
		signal