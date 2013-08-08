translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #mostRecentlyUsedPage type: #'StackPage *';
		var: #stackBasePlus1 type: #'char *';
		var: #pages type: #'StackPage *'.
	aCCodeGenerator
		removeVariable: 'coInterpreter'; "These are simulation/debugging things only"
		removeVariable: 'objectMemory'; "These are simulation/debugging things only"
		removeVariable: 'pageMap'; "These are simulation/debugging things only"
		removeVariable: 'maxStackAddress'; "These are simulation/debugging things only"
		removeVariable: 'minStackAddress'; "These are simulation/debugging things only"
		removeMethodForSelector: #memIndexFor: