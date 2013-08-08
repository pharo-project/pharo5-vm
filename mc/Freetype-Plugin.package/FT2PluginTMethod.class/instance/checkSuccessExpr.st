private
checkSuccessExpr
	"Return the parse tree for an expression that aborts the primitive if the successFlag is not true."

	| expr |
	expr := 'interpreterProxy failed ifTrue: [self ftParameterError. ^nil ]'.
	^ self statementsFor: expr varName: ''
