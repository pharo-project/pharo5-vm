translation
prepareToBeAddedToCodeGenerator: aCodeGen
	aCodeGen
		removeVariable: 'coInterpreter';
		removeVariable: 'cogit'