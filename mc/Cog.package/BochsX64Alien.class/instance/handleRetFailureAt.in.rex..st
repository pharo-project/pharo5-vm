error handling
handleRetFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" rex: rexByteOrNil "<Integer|nil>"
	"Convert an execution primitive failure for a ret into a ProcessorSimulationTrap signal."
	self shouldBeImplemented.
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 1
			address: (memoryArray unsignedLong64At: self rsp + 1)
			type: #return
			accessor: #rip:)
		signal