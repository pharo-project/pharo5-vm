bytecode generators
genV4SpecialSelectorSend
	| index selector numArgs |
	index := byte0 - 80.
	selector := coInterpreter specialSelector: index.
	numArgs := coInterpreter specialSelectorNumArgs: index.
	^self genSend: selector numArgs: numArgs