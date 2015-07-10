simulation only
handleABICallOrJumpSimulationTrap: aProcessorSimulationTrap evaluable: evaluable
	self assert: aProcessorSimulationTrap type = #call.
	processor
		simulateLeafCallOf: aProcessorSimulationTrap address
		nextpc: aProcessorSimulationTrap nextpc
		memory: coInterpreter memory.
	self recordInstruction: {'(simulated call of '. aProcessorSimulationTrap address. '/'. evaluable selector. ')'}.
	evaluable valueWithArguments: (processor
										postCallArgumentsNumArgs: evaluable numArgs
										in: coInterpreter memory).
	self recordInstruction: {'(simulated return to '. processor retpcIn: coInterpreter memory. ')'}.
	processor
		smashCallerSavedRegistersWithValuesFrom: 16r80000000 by: objectMemory wordSize;
		simulateLeafReturnIn: coInterpreter memory