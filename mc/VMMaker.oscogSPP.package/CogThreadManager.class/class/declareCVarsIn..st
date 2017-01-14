translation
declareCVarsIn: cCodeGen
	cCodeGen
		removeVariable: 'coInterpreter';
		removeVariable: 'cogit';
		removeVariable: 'threadLocalStorage';
		removeVariable: 'processorOwner'.
	cCodeGen
		var: #threads type: #'CogVMThread **';
		var: #vmOSThread type: #sqOSThread