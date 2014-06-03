C code generation
emitValueExpansionOn: aStream level: level generator: aCodeGen
	| stmtList lastStmt copy |
	self assert: (expression isSend and: [expression isValueExpansion]).
	stmtList := expression receiver.
	lastStmt := stmtList statements last.
	lastStmt = variable ifTrue:
		[^expression emitCCodeOn: aStream level: level generator: aCodeGen].
	copy := stmtList copy.
	copy statements
		at: stmtList statements size
		put: (TAssignmentNode new
				setVariable: variable
				expression: lastStmt).
	(TSendNode new
			setSelector: expression selector
			receiver: copy
			arguments: expression args)
		emitCCodeOn: aStream level: level generator: aCodeGen.