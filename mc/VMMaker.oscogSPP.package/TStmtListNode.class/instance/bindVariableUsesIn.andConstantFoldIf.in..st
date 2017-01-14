transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newStatements |
	newStatements := statements collect: [:s| s bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^newStatements = statements
		ifTrue: [self]
		ifFalse:
			[self shallowCopy
				setStatements: newStatements;
				yourself]