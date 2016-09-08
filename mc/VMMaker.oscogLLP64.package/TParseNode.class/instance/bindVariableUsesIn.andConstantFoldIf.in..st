transformations
bindVariableUsesIn: aDictionary andConstantFoldIf: constantFold in: codeGen
	"Answer either the receiver, if it contains no references to the given variables, or a new node with the given variables rebound.
	 But do not change variables that appear on the left-hand-side of an assignment statement."
	^self
