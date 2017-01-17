primitive compilation
checkSuccessExpr
	"Answer the parse tree for an expression that aborts the primitive if there has been a failure."
	^self
		statementsFor: 'interpreterProxy failed ifTrue: [^nil]'
		varName: ''