C code generation
emitStatementListExpansion: stmtList on: aStream level: level generator: aCodeGen
	| lastStmt copy |
	lastStmt := stmtList statements last.
	lastStmt = variable ifTrue:
		[^expression emitCCodeOn: aStream level: level generator: aCodeGen].
	copy := stmtList copy.
	copy statements
		at: stmtList statements size
		put: (TAssignmentNode new
				setVariable: variable
				expression: lastStmt).
	copy emitCCodeOn: aStream level: level generator: aCodeGen