memory
readFault: address
	| destReg |
	self assert: inDelaySlot not. "Or we have to store nextPC somewhere."
	destReg := (MIPSInstruction new value: (self fetchInstruction: pc)) rt.
	
	^(ProcessorSimulationTrap
			pc: pc
			nextpc: pc + 4
			address: address
			type: #read
			accessor: (self setterForRegister: destReg))
		signal
