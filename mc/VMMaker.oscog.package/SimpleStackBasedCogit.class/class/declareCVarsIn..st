translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		var: #externalPrimCallOffsets
			declareC: 'sqInt externalPrimCallOffsets[MaxNumArgs + 1]';
		var: #externalPrimJumpOffsets
			declareC: 'sqInt externalPrimJumpOffsets[MaxNumArgs + 1]';
		var: #externalSetPrimOffsets
			declareC: 'sqInt externalSetPrimOffsets[MaxNumArgs + 1]';
		var: #primSetFunctionLabel type: #'AbstractInstruction *';
		var: #primInvokeInstruction type: #'AbstractInstruction *'