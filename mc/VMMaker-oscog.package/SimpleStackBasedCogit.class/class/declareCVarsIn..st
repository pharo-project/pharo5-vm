translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #externalPrimCallOffsets
			declareC: 'sqInt externalPrimCallOffsets[MaxNumArgs + 1]';
		var: #externalPrimJumpOffsets
			declareC: 'sqInt externalPrimJumpOffsets[MaxNumArgs + 1]'