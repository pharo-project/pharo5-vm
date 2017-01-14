C code generation
emitStatementListExpansionAsExpression: stmtList on: aStream level: level generator: aCodeGen
	stmtList statements last = variable ifTrue:
		[^expression emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	stmtList copy
		assignLastExpressionTo: variable;
		emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen