transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound."
	| newMethod |
	newMethod := method bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen.
	^newMethod = method
		ifTrue: [self]
		ifFalse: [self shallowCopy
					method: newMethod;
					yourself]