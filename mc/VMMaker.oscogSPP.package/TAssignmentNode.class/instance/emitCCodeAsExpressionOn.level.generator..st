C code generation
emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen
	(expression isStmtList and: [expression statements size > 1]) ifTrue:
		[^self emitStatementListExpansionAsExpression: expression on: aStream level: level generator: aCodeGen].
	aStream nextPut: $(.
	self emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)