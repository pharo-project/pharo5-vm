transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newCaseLabels newCases |
	newCaseLabels := caseLabels collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	newCases := cases collect: [:node| node bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen].
	^(newCaseLabels = caseLabels
	   and: [newCases = cases])
		ifTrue: [self]
		ifFalse: [self shallowCopy
					caseLabels: newCaseLabels;
					cases: newCases;
					yourself]