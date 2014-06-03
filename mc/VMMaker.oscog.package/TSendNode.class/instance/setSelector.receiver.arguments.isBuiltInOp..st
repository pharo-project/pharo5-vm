accessing
setSelector: aSymbol receiver: rcvrNode arguments: argList isBuiltInOp: builtinFlag

	selector := aSymbol.
	receiver := rcvrNode.
	arguments := argList asArray.
	isBuiltinOperator := builtinFlag.