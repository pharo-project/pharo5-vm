translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		removeVariable: 'coInterpreter';
		removeVariable: 'objectRepresentation'.
	
	self declareC: #(youngReferrers mzFreeStart baseAddress limitAddress)
			as: #usqInt
				in: aCCodeGenerator.
	aCCodeGenerator var: 'unpairedMethodList' type: #'CogMethod *'