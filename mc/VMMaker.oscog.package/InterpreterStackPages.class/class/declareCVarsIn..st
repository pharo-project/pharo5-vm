translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #stackMemory type: 'char *';
		removeVariable: 'indexOffset'; "These are simulation/debugging things only"
		removeVariable: 'pageSizeInSlots' "These are simulation/debugging things only"