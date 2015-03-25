simulation only
shortcutTrampoline: aProcessorSimulationTrap to: aBlock
	<doNotGenerate>
	coInterpreter printFrameAtEachStep ifTrue:
		[coInterpreter
			printFrame: processor fp
			WithSP: processor sp].
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
	coInterpreter printFrameAtEachStep ifTrue:
		[coInterpreter
			printFrame: processor fp
			WithSP: processor sp]