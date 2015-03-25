simulation only
shortcutTrampoline: aProcessorSimulationTrap to: aBlock
	<doNotGenerate>
	backEnd hasLinkRegister ifTrue:
		[processor pushWord: processor lr in: coInterpreter memory].
	processor
		simulateLeafCallOf: aProcessorSimulationTrap address
		nextpc: aProcessorSimulationTrap nextpc
		memory: coInterpreter memory.
	coInterpreter
		stackPointer: processor sp;
		framePointer: processor fp.
	processor
		sp: self getCStackPointer;
		fp: self getCFramePointer.
	aBlock value.
	processor
		sp: coInterpreter stackPointer;
		fp: coInterpreter framePointer;
		simulateLeafReturnIn: coInterpreter memory.
	backEnd hasLinkRegister ifTrue:
		[processor lr: (processor popWordIn: coInterpreter memory)]