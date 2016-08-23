simulation only
handleABICallOrJumpSimulationTrap: aProcessorSimulationTrap evaluable: evaluable
	<doNotGenerate>

	self assert: aProcessorSimulationTrap type = #call.
	processor
		simulateLeafCallOf: aProcessorSimulationTrap address
		nextpc: aProcessorSimulationTrap nextpc
		memory: coInterpreter memory.
	self recordInstruction: {'(simulated call of '. aProcessorSimulationTrap address. '/'. evaluable selector. ')'}.
	((printRegisters or: [printInstructions]) and: [clickConfirm]) ifTrue:
 		[(self confirm: 'skip run-time call?') ifFalse:
			[clickConfirm := false. self halt]].
	evaluable valueWithArguments: (processor
										postCallArgumentsNumArgs: evaluable numArgs
										in: coInterpreter memory).
	self recordInstruction: {'(simulated return to '. processor retpcIn: coInterpreter memory. ')'}.
	processor
		smashABICallerSavedRegistersWithValuesFrom: 16r80000000 by: objectMemory wordSize;
		simulateLeafReturnIn: coInterpreter memory