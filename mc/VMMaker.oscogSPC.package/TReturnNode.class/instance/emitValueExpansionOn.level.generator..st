C code generation
emitValueExpansionOn: aStream level: level generator: aCodeGen
	| stmtList lastStmt copy |
	self assert: (expression isSend and: [expression isValueExpansion]).
	stmtList := expression receiver.
	lastStmt := stmtList statements last.
	lastStmt isReturn ifTrue:
		[^expression emitCCodeOn: aStream level: level generator: aCodeGen].
	copy := stmtList copy.
	copy statements
		at: stmtList statements size
		put: (TReturnNode new setExpression: lastStmt).
	copy emitCCodeOn: aStream level: level generator: aCodeGen