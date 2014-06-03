bytecode generators
genSpecialSelectorSend
	| index selector numArgs |
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	selector := coInterpreter specialSelector: index.
	numArgs := coInterpreter specialSelectorNumArgs: index.
	^self genSend: selector numArgs: numArgs