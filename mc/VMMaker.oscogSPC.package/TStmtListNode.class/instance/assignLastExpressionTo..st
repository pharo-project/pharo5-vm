transformations
assignLastExpressionTo: variableNode
	"Destructively transform the receiver so that its last expression is assigned to the argument."
	| index |
	index := statements findLast: [:expr| (expr isGoTo or: [expr isLabel]) not].
	statements
		at: index
		put: (TAssignmentNode new
				setVariable: variableNode
				expression: (statements at: index))