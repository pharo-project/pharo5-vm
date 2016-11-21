initialize-release
initialize
	objectMemory := self class objectMemoryClass simulatorClass new.
	objectMemory allocateMemoryOfSize: 1024*1024.
	memory := objectMemory memory.
	objectMemory
		initializeFreeSpaceForFacadeFrom: self startOfMemory
		to: self variablesBase.
	coInterpreter := CoInterpreter new.
	coInterpreter
		instVarNamed: 'objectMemory'
			put: objectMemory;
		instVarNamed: 'primitiveTable'
			put: (CArrayAccessor on: CoInterpreter primitiveTable copy).
	variables := Dictionary new