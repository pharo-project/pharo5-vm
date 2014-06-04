transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it is not a reference to one of the given variables, or the replacement if it is."
	^(aDictionary at: name ifAbsent: [^self]) copy