C translation
declareCVarsIn: aCodeGen
	aCodeGen
		var: #scratchSimStack
			type: #'CogSimStackEntry *';
		var: #scratchOptStatus
			type: #CogSSOptStatus