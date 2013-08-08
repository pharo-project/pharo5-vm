error handling
handleMoveAwRFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Convert an execution primitive failure for a register load from an Address into a ProcessorSimulationTrap signal."
	((memoryArray byteAt: pc + 4) = 16rE5  "test for E593 as the most significant two bytes"
		and: [(memoryArray byteAt: pc + 3) = (16r90 + (CogARMCompiler classPool at: #RISCTempReg))])
		ifTrue:
			[(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + 4 
					address: (memoryArray byteAt: pc + 1) "address, combined from four instructions"
								+ ((memoryArray byteAt: pc - 3) << 24) 
								+ ((memoryArray byteAt: pc - 7) << 16) 
								+ ((memoryArray byteAt: pc - 11) << 8)
					type: #read
					accessor: (self registerStateSetters at: ((memoryArray byteAt: pc + 2) >> 4) + 1))
				signal]
		ifFalse:
			[self reportPrimitiveFailure]