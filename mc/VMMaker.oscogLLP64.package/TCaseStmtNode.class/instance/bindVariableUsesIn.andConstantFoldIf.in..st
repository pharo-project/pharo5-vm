transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newExpression newCases |
	newExpression := expression bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	newCases := cases collect: [:c| c bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^(newExpression = expression
	   and: [newCases = cases])
		ifTrue: [self]
		ifFalse: [self shallowCopy
					setExpression: newExpression cases: newCases;
					yourself]