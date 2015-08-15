translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #stackBasePlus1 type: #'char *';
		removeVariable: 'pageMap'; "These are simulation/debugging things only"
		removeVariable: 'maxStackAddress'; "These are simulation/debugging things only"
		removeVariable: 'minStackAddress' "These are simulation/debugging things only"