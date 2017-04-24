C translation
declareCVarsIn: aCodeGen
	aCodeGen
		var: #scratchSimStack
			type: #'SimStackEntry *';
		var: #scratchSimSelf
			type: #SimStackEntry