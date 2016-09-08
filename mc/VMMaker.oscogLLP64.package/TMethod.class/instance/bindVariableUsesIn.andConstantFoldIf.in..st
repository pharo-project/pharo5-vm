transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newParseTree |
	newParseTree := parseTree bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	^newParseTree = parseTree
		ifTrue: [self]
		ifFalse: [self shallowCopy
					parseTree: newParseTree;
					yourself]