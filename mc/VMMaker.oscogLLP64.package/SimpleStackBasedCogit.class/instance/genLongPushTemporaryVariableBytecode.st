bytecode generators
genLongPushTemporaryVariableBytecode
	"230		11100110	i i i i i i i i	Push Temporary Variable #iiiiiiii"
	^self genPushTemporaryVariable: byte1