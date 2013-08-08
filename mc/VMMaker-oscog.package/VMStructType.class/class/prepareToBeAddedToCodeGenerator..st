translation
prepareToBeAddedToCodeGenerator: aCodeGen
	aCodeGen
		removeVariable: 'coInterpreter';
		removeVariable: 'cogit';
		removeVariable: 'objectMemory';
		removeVariable: 'objectRepresentation' ifAbsent: []