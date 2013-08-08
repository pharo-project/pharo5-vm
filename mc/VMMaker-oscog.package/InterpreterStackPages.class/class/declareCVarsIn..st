translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #stackMemory type: 'char *';
		var: #mostRecentlyUsedPage type: 'StackPage *';
		var: #pages type: 'StackPage *'.
	aCCodeGenerator	"These are simulation/debugging things only"
		removeVariable: 'interpreter';
		removeVariable: 'indexOffset';
		removeVariable: 'pageSizeInSlots';
		removeMethodForSelector: #memIndexFor: