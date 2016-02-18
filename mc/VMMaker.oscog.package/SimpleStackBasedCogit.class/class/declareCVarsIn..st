translation
declareCVarsIn: aCCodeGenerator

	aCCodeGenerator vmClass primitiveTable ifNotNil:
		[:bytecodeGenTable|
		aCCodeGenerator
			var: #primitiveGeneratorTable
				declareC: 'static PrimitiveDescriptor primitiveGeneratorTable[MaxCompiledPrimitiveIndex+1]',
							(self tableInitializerFor: aCCodeGenerator vmClass primitiveTable
								in: aCCodeGenerator)].
	aCCodeGenerator
		var: #externalPrimCallOffsets
			declareC: 'sqInt externalPrimCallOffsets[MaxNumArgs + 1]';
		var: #externalPrimJumpOffsets
			declareC: 'sqInt externalPrimJumpOffsets[MaxNumArgs + 1]';
		var: #externalSetPrimOffsets
			declareC: 'sqInt externalSetPrimOffsets[MaxNumArgs + 1]';
		var: #primSetFunctionLabel type: #'AbstractInstruction *';
		var: #primInvokeInstruction type: #'AbstractInstruction *'