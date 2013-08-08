transformations
removeFinalSelfReturn
	"The Smalltalk parser automatically adds the statement '^self' to the end of methods
	 without explicit returns.  This method removes such statements, since in most VMMaker
	 classes (except struct classes) the generated code has no notion of 'self' anyway.
	 If the statement is removed and no return type has yet been specified asnd the class
	 specifies a default return type (e.g. #void) for methods that don't return, then set the
	 return type accordingly."

	| lastStmt |
	((lastStmt := parseTree statements last) isReturn
	 and: [lastStmt expression isVariable
	 and: ['self' = lastStmt expression name]]) ifTrue:
		[| tokens |
		tokens := Scanner new scanTokens: (definingClass sourceCodeAt: selector ifAbsent: ['']).
		(tokens size < 2
		 or: [(tokens last: 2) ~= #(#'^' 'self')]) ifTrue:
			[parseTree setStatements: parseTree statements allButLast.
			 returnType = #sqInt ifTrue:
				[([definingClass implicitReturnTypeFor: selector]
					on: MessageNotUnderstood
					do: [:ex| nil]) ifNotNil:
						[:defaultReturnType|
						returnType := defaultReturnType]]]]