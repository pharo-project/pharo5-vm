transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	"Do NOT bind the variable on the left-hand-side of an assignment statement."
	| boundExpression |
	boundExpression := expression bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	^boundExpression == expression
		ifTrue: [self]
		ifFalse: [self shallowCopy
					setVariable: variable expression: boundExpression;
					yourself]