bytecode generators
genSpecialSelectorSend
	| index numArgs |
	index := byte0 - self firstSpecialSelectorBytecodeOffset.
	numArgs := coInterpreter specialSelectorNumArgs: index.
	^self genSend: index negated - 1 numArgs: numArgs