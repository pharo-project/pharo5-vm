public
addConstantForBinding: variableBinding
	"Add the pool variable to the code base as a constant."
	| node val |
	val := variableBinding value.
	node := (useSymbolicConstants and: [self isCLiteral: val])
				ifTrue:[TDefineNode new
							setName: variableBinding key
							value: variableBinding value]
				ifFalse:[TConstantNode new setValue: variableBinding value].
	constants at: variableBinding key put: node