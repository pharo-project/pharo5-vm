translation
prepareToBeAddedToCodeGenerator: aCodeGen
	aCodeGen
		removeVariable: 'coInterpreter';
		removeVariable: 'objectMemory'