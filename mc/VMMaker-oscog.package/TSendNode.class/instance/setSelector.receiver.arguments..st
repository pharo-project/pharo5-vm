accessing
setSelector: aSymbol receiver: rcvrNode arguments: argList

	selector := aSymbol.
	receiver := rcvrNode.
	arguments := argList asArray.
	isBuiltinOperator := false.