transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newExpression |
	newExpression := expression bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	^newExpression = expression
		ifTrue: [self]
		ifFalse:
			[self shallowCopy
				setExpression: newExpression;
				yourself]