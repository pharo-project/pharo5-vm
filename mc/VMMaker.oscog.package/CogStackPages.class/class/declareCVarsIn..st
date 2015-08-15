translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #mostRecentlyUsedPage type: #'StackPage *';
		var: #pages type: #'StackPage *'.
	aCCodeGenerator
		removeVariable: 'coInterpreter'; "These are simulation/debugging things only"
		removeVariable: 'objectMemory' "These are simulation/debugging things only"