translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		removeVariable: 'coInterpreter';
		removeVariable: 'objectRepresentation'.
	
	self declareC: #(youngReferrers mzFreeStart baseAddress limitAddress unpairedMethodList)
		as: #usqInt
		in: aCCodeGenerator