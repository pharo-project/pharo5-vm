C code generation
emitStatementListExpansion: stmtList on: aStream level: level generator: aCodeGen
	stmtList statements last = variable ifTrue:
		[^expression emitCCodeOn: aStream level: level generator: aCodeGen].
	stmtList copy
		assignLastExpressionTo: variable;
		emitCCodeOn: aStream level: level generator: aCodeGen