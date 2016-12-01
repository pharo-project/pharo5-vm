C translation
declareCVarsIn: aCodeGen
	aCodeGen
		var: #scratchSimStack
			type: #'SimStackEntry *';
		var: #scratchOptStatus
			type: #CogSSOptStatus