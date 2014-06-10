error handling
handleMoveAwRFailureAt: pc "<Integer>" in: memoryArray "<Bitmap|ByteArray>"
	"Convert an execution primitive failure for a register load from an Address into a ProcessorSimulationTrap signal."
	((memoryArray byteAt: pc + 4) = 16rE5  "test for 0xE59X as the most significant two bytes - X being the index of the RISCTempReg (or 0xA in current code).
		LDR Rx, [RiscTempReg, #0]"
		and: [(memoryArray byteAt: pc + 3) = (16r90 + CogARMCompiler ARMTempReg)])
		ifTrue:
			[(ProcessorSimulationTrap
					pc: pc
					nextpc: pc + 4 
					address: (memoryArray byteAt: pc -3) "address, combined from prior four MOV/ORR instructions. See CogARMCompiler>concretizeMoveAwR"
								+ ((memoryArray byteAt: pc - 7) << 8) 
								+ ((memoryArray byteAt: pc - 11) << 16) 
								+ ((memoryArray byteAt: pc - 15) << 24)
					type: #read
					accessor: (self registerStateSetters at: ("destination register" (memoryArray byteAt: pc + 2) >> 4) + 1))
				signal]
		ifFalse:
			[self reportPrimitiveFailure]