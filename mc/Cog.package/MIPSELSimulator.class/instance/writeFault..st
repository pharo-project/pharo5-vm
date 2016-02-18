memory
writeFault: address
	| srcReg |
	self assert: inDelaySlot not. "Or we have to store nextPC somewhere."
	srcReg := (MIPSInstruction new value: (self fetchInstruction: pc)) rt.
	
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: address
			type: #write
			accessor: (self getterForRegister: srcReg))
		signal
