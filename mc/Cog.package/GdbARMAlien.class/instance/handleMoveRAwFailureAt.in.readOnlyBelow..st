error handling
handleMoveRAwFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Convert an execution primitive failure for a register write into Memory at a predefined address into a ProcessorSimulationTrap signal."
	^((memoryArray byteAt: pc + 4) = 16rE5 
		and: [(memoryArray byteAt: pc + 3) = (16r80 + (CogARMCompiler classPool at: #RISCTempReg))])
		ifTrue:
			[(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + 4
					address: (memoryArray byteAt: pc + 1) 
								+ ((memoryArray byteAt: pc - 3) << 24) 
								+ ((memoryArray byteAt: pc - 7) << 16) 
								+ ((memoryArray byteAt: pc - 11) << 8)
					type: #write
					accessor: (self registerStateNames at: ((memoryArray byteAt: pc + 2) >> 4) + 1))
				signal]
		ifFalse:
			[self reportPrimitiveFailure]